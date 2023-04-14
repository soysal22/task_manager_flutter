// ignore_for_file: body_might_complete_normally_nullable

import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manger_mission/core/constants/constants.dart';
import 'package:manger_mission/core/controllers/task_controller.dart';
import 'package:manger_mission/core/models/auth__model.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:manger_mission/view/auth/login_page.dart';
import 'package:manger_mission/view/deneme/deneme_obx_home.dart';

class AuthController extends GetxController {
  // Auth controller instance  ..
  static AuthController get instance => Get.put(AuthController());
  // email , password , name ....

  final TaskController taskController = Get.put(TaskController());

  FirebaseAuth auth = FirebaseAuth.instance;
  late final Rx<User?> _user;

  @override
  void onReady() {
    _user = Rx<User?>(auth.currentUser);
    _user.bindStream(auth.userChanges());

    super.onReady();
  }

  // @override
  // void onReady() {
  //   super.onReady();
  //   _user = Rx<User?>(auth.currentUser);
  //   _user.bindStream(auth.userChanges());
  //   ever(_user, initialScreen);
  // }

  // initialScreen(User? user) {
  //   user == null
  //       ? Get.offAll(() => const LoginPage())
  //       : Get.offAll(() => const HomePage());
  // }

  void login({required AuthModel? authModel, BuildContext? context}) async {
    Get.dialog(const Center(child: CircularProgressIndicator()));

    try {
      await auth
          .signInWithEmailAndPassword(
              email: authModel!.email!, password: authModel.password!)
          .then((value) {
        log("Giriş başarılı");
        _user.value != null
            ? Get.offAll(() => const DenemeHome())
            : Get.offAll(() => const LoginPage());
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
    Get.back();
  }

  void register({required AuthModel? authModel}) async {
    Get.dialog(const Center(child: CircularProgressIndicator()));

    try {
      await auth
          .createUserWithEmailAndPassword(
              email: authModel!.email!, password: authModel.password!)
          .then((value) async {
        taskController.addNewUser();
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
    Get.back();
  }
}

/// login With google

Future<UserCredential?> signInWithGoogle() async {
  Get.dialog(const Center(child: CircularProgressIndicator()));
  //<UserCredential>
  try {
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
  } catch (e) {
    log(e.toString());
  }
  Get.back();
}

Future<void> sigInOutWithGoogle() async {
  try {
    await FirebaseAuth.instance.signOut();

    await GoogleSignIn().signOut();
  } catch (e) {
    log(e.toString());
  }
}
