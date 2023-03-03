import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manger_mission/core/constants/constants.dart';
import 'package:manger_mission/core/themes/themes.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.snackbar("Tasarım Aşamasındadır", "TO BE CONTUNİED",
            snackPosition: SnackPosition.TOP,
            icon: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(Icons.warning_amber, size: 30)));
      },
      child: SizedBox(
        width: Get.width,
        height: 60,
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
}
