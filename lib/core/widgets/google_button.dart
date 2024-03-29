import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manger_mission/core/constants/constants.dart';
import 'package:manger_mission/core/style/textStyle.dart';
import 'package:manger_mission/core/controllers/auth_controller.dart';
import 'package:manger_mission/view/home_page.dart';

class GoogleButton extends StatefulWidget {
  const GoogleButton({super.key});

  @override
  State<GoogleButton> createState() => _GoogleButtonState();
}

class _GoogleButtonState extends State<GoogleButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        googleGiris();
      },
      child: SizedBox(
        width: Get.width,
        height: Get.width / 7,
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: Constants.borderRadius10),
          elevation: 5,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: Constants.colorWhite,
                child: Image.asset(
                  Constants.imageGoogle,
                  fit: BoxFit.contain,
                ),
              ),
              Constants.sizedBoxWidth10,
              _buttonText(context, "Google"),
            ],
          ),
        ),
      ),
    );
  }

  Text _buttonText(BuildContext context, String title) {
    return Text(
      title,
      style: buttonTextStyleBlack,
    );
  }

  googleGiris() {
    signInWithGoogle().then((value) {
      log("${FirebaseAuth.instance.currentUser!.displayName} Kullanıcısının Girişi Başarılı");

      Get.to(() => const HomePage());
    });
  }
}
