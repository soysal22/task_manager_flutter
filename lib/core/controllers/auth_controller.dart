import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manger_mission/core/constants/constants.dart';
import 'package:manger_mission/core/controllers/task_controller.dart';
import 'package:manger_mission/core/models/auth__model.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:manger_mission/view/auth/login_page.dart';
import 'package:manger_mission/view/home_page.dart';

class AuthController extends GetxController {
  // Auth controller instance  ..
  static AuthController instance = Get.find();
  // email , password , name ....
  // late var _user;

  final TaskController authTaskController = Get.put(TaskController());

  FirebaseAuth auth = FirebaseAuth.instance;
  late final Rx<User?> _user;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(auth.currentUser);
    _user.bindStream(auth.userChanges());
    ever(_user, initialScreen);
  }

  initialScreen(User? user) {
    user == null
        ? Get.offAll(() => const LoginPage())
        : Get.offAll(() => const HomePage());
  }

  void login({required AuthModel? authModel, BuildContext? context}) async {
    try {
      await auth
          .signInWithEmailAndPassword(
              email: authModel!.email!, password: authModel.password!)
          .then((value) {
        log("Giriş başarılı");
        _user.value != null
            ? Get.offAll(() => const HomePage())
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
  }

  void register({required AuthModel? authModel}) async {
    try {
      await auth
          .createUserWithEmailAndPassword(
              email: authModel!.email!, password: authModel.password!)
          .then((value) async {
        authTaskController.addNewUser().then((value) async {
          log("User Created");
        });
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
