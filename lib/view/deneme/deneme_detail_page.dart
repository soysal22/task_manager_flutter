import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manger_mission/core/constants/constants.dart';
import 'package:manger_mission/core/models/task_model.dart';
import 'package:manger_mission/core/themes/themes.dart';

class DenemeDetail extends StatelessWidget {
  final TaskModel task;
  const DenemeDetail({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        backgroundColor:
            Get.isDarkMode ? Constants.colorGrey : Constants.colorWhite,
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back_ios_new,
              color:
                  Get.isDarkMode ? Constants.colorWhite : Constants.colorBlack,
              size: 30,
            )),
        centerTitle: true,
        title: Text(
          task.title ?? "title empty",
          style: titleStyle,
        ),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.only(
              top: Get.width / 5,
              bottom: Get.width / 5,
              left: Get.width / 8,
              right: Get.width / 8),
          decoration: BoxDecoration(
              color: Constants.colorGrey,
              borderRadius: Constants.borderRadius20),
          child: Center(
              child: Text(
            task.note ?? "title empty",
          )),
        ),
      ),
    );
  }
}
