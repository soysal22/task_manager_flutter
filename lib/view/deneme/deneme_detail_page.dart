import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:manger_mission/core/constants/constants.dart';
import 'package:manger_mission/core/models/task_model.dart';
import 'package:manger_mission/core/themes/themes.dart';

class DenemeDetail extends StatelessWidget {
  final TaskModel task;
  DenemeDetail({super.key, required this.task});

  final double size = Get.width / 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: _appbarDesign(),

      // Icon(Icons.access_time_sharp, color: Constants.colorGrey)

      body: Padding(
        padding: EdgeInsets.only(
            top: Get.width / 8,
            bottom: Get.width / 3.5,
            left: size,
            right: size),
        child: Center(
          child: Column(
            children: [
              Text(
                "Hello , ${FirebaseAuth.instance.currentUser!.displayName ?? "U.Name"}",
                style: detailTitleStyle,
              ),
              Constants.sizedBoxHeight10,
              Text(
                "You have a new reminder ",
                style: subHeadingStyle,
              ),
              const Spacer(),
              Constants.sizedBoxHeight10,
              Container(
                width: Get.width,
                height: Get.width * 1.2,
                decoration: BoxDecoration(
                    color: Constants.blusihColor,
                    borderRadius: Constants.borderRadius40),
                child: Padding(
                  padding: EdgeInsets.only(top: size, left: size),
                  child: Column(
                    //  mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task.title ?? "empty ",
                        style: titleStyleWhite,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _appbarDesign() {
    return AppBar(
      elevation: 0,
      backgroundColor: Constants.primaryColor,
      automaticallyImplyLeading: false,
      leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Constants.colorWhite,
            size: 25,
          )),
      centerTitle: true,
      title: Text(
        "Flutter",
        style: GoogleFonts.lato(
            textStyle: const TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
          color: Constants.colorWhite,
        )),
      ),
    );
  }
}
