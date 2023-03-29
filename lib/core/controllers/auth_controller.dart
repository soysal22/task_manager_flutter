// ignore_for_file: avoid_print

import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manger_mission/core/constants/constants.dart';
import 'package:manger_mission/core/models/auth__model.dart';
import 'package:manger_mission/view/auth/login_page.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:manger_mission/view/deneme/deneme_home.dart';
import 'package:manger_mission/view/splash_screen.dart';

class AuthController extends GetxController {
  // Auth controller instance  ..
  static AuthController instance = Get.find();
  // email , password , name ....
  late Rx<User?> _user;

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(auth.currentUser);
    _user.bindStream(auth.userChanges());
    ever(_user, initialScreen);
  }

  initialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => const LoginPage());
    } else {
      Get.offAll(() => const DenemeHome());
    }
  }

  void register({required AuthModel? authModel}) async {
    try {
      await auth
          .createUserWithEmailAndPassword(
              email: authModel!.email!, password: authModel.password!)
          .then((value) {
        Get.snackbar(
          "About User",
          "User Message",
          backgroundColor: Constants.colorRed,
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 5),
          titleText: const Text(
            "Account Creation succesfuly",
            style: TextStyle(color: Constants.colorWhite),
          ),
        );
        Future.delayed(Duration.zero, () => Get.to(() => const SplashScreen()));
      });
    } catch (e) {
      Get.snackbar("About User", "User Message",
          backgroundColor: Constants.colorRed,
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 5),
          titleText: const Text(
            "Account Creation Failed",
            style: TextStyle(color: Constants.colorWhite),
          ),
          messageText: Text(
            e.toString(),
            style: const TextStyle(color: Constants.colorWhite),
          ));
    }
  }

  void login({required AuthModel? authModel}) async {
    try {
      await auth
          .signInWithEmailAndPassword(
              email: authModel!.email!, password: authModel.password!)
          .then((value) {
        print("Giriş başarılı");

        Get.to(() => const DenemeHome());
      });
    } catch (e) {
      Get.snackbar("About Login", "Login Message",
          backgroundColor: Constants.colorRed,
          snackPosition: SnackPosition.TOP,
          titleText: const Text(
            "Login Failed",
            style: TextStyle(color: Constants.colorWhite),
          ),
          messageText: Text(
            e.toString(),
            style: const TextStyle(color: Constants.colorWhite),
          ));
    }
  }
}

/// logiin With google

Future<UserCredential> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}

Future<void> sigInOutWithGoogle() async {
  await FirebaseAuth.instance.signOut();

  await GoogleSignIn().signOut();
}
