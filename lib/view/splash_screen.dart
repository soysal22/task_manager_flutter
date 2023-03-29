import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manger_mission/core/constants/constants.dart';
import 'package:manger_mission/view/auth/login_page.dart';
import 'package:manger_mission/view/deneme/deneme_home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // @override
  // void initState() {
  //   Future.delayed(const Duration(seconds: 2));
  //   firebaseInit();
  //   super.initState();
  // }

  // Future<void> firebaseInit() async {
  //   WidgetsFlutterBinding.ensureInitialized();
  //   await Firebase.initializeApp();
  //   setState(() {
  //     if (FirebaseAuth.instance.currentUser != null) {
  //       log(" ${FirebaseAuth.instance.currentUser!.displayName!} Kullanıcısı Giriş Yaptı");
  //       Get.offAll(() => const DenemeHome());
  //     } else {
  //       Get.to(() => const LoginPage());
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: null,
          body: Center(
            child: Image.asset(
              Constants.imageSplash,
              fit: BoxFit.cover,
            ),
          )),
    );
  }
}
