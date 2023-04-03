// ignore_for_file: avoid_print

import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manger_mission/core/constants/constants.dart';
import 'package:manger_mission/core/models/auth__model.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:manger_mission/view/deneme/deneme_home.dart';

class AuthController extends GetxController {
  // Auth controller instance  ..
  static AuthController instance = Get.put(AuthController());
  // email , password , name ....
  // late var _user;

  FirebaseAuth auth = FirebaseAuth.instance;

  // @override
  // void onReady() {
  //   super.onReady();
  //   _user = auth.currentUser;
  //   _user.bindStream(auth.userChanges());
  //   //   ever(_user, initialScreen);
  // }

  // initialScreen(User? user) {
  //   if (user == null) {
  //     Get.offAll(() => const LoginPage());
  //   } else {
  //     Get.offAll(() => const DenemeHome());
  //   }
  // }

  void login({required AuthModel? authModel, BuildContext? context}) async {
    try {
      await auth
          .signInWithEmailAndPassword(
              email: authModel!.email!, password: authModel.password!)
          .then((value) {
        print("Giriş başarılı");
        Future.delayed(const Duration(seconds: 1));
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

  void register({required AuthModel? authModel}) async {
    try {
      await auth
          .createUserWithEmailAndPassword(
              email: authModel!.email!, password: authModel.password!)
          .then((value) {
        denemeTaskController.addNewUser();
        log("Users Created");
        Future.delayed(const Duration(seconds: 1));
        Get.back();
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
