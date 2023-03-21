// ignore_for_file: prefer_typing_uninitialized_variables, deprecated_member_use, avoid_print, unnecessary_null_comparison
import 'dart:developer';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:manger_mission/core/constants/constants.dart';
import 'package:manger_mission/core/controllers/deneme_task.dart';
import 'package:manger_mission/core/controllers/task_controller.dart';
import 'package:manger_mission/core/models/task_model.dart';
import 'package:manger_mission/core/service/notification_service.dart';
import 'package:manger_mission/core/service/theme_services.dart';
import 'package:manger_mission/core/themes/themes.dart';
import 'package:manger_mission/core/widgets/my_button.dart';
import 'package:manger_mission/core/widgets/task_tile.dart';
import 'package:manger_mission/view/add_task_page.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:manger_mission/view/deneme/deneme_add.dart';

class DenemeHome extends StatefulWidget {
  const DenemeHome({super.key});

  @override
  State<DenemeHome> createState() => _DenemeHomeState();
}

class _DenemeHomeState extends State<DenemeHome> {
  var notifyHelper = NotifyHelper();

  DateTime selectedDate = DateTime.now();

  final DenemeTaskController taskController = Get.put(DenemeTaskController());

  // @override
  // void initState() {
  //   super.initState();
  //   notifyHelper.initializeNotification();
  //   notifyHelper.requestIOSPermissions();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      extendBody: true,
      appBar: _appBarDesign(),
      body: Column(
        children: [
          _addTaskBar(),
          _addDateBar(),

          // Firebase datasınıngeleceği yer
          const FirebaseGetData(),
        ],
      ),
    );
  }

  Padding _addDateBar() {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: DatePicker(
        DateTime.now(),
        height: 100,
        width: 80,
        initialSelectedDate: DateTime.now(),
        selectionColor: Constants.primaryColor,
        selectedTextColor: Constants.colorWhite,
        dateTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Constants.colorGrey),
        ),
        dayTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Constants.colorGrey),
        ),
        monthTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Constants.colorGrey),
        ),
        onDateChange: (date) {
          setState(() {
            selectedDate = date;
          });
        },
      ),
    );
  }

  Widget _addTaskBar() {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat.yMMMMd().format(DateTime.now()),
                style: subHeadingStyle,
              ),
              Text(
                "Today",
                style: headingStyle,
              )
            ],
          ),
          MyButton(
            title: "+ Add Task",
            onPressed: () {
              Get.to(() => const DenemeAddPage());
            },
          ),
        ],
      ),
    );
  }

  AppBar _appBarDesign() {
    return AppBar(
      elevation: 0,
      backgroundColor: context.theme.backgroundColor,
      automaticallyImplyLeading: false,
      title: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              // "Welcome ${FirebaseAuth.instance.currentUser?.displayName! ?? " empty "}",
              "K.Name",
              style: titleStyle,
            ),
            Constants.sizedBoxWidth10,
            const CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage("assets/images/person.png"),
            ),
            Constants.sizedBoxWidth10,
            IconButton(
                onPressed: () {
                  //sigInOutWithGoogle();
                  //  log("${FirebaseAuth.instance.currentUser?.displayName} Kullanıcısı Çıkış Yaptı");
                  //Get.to(() => const SplashScreen());
                },
                icon: Icon(
                  Icons.power_settings_new_rounded,
                  size: 35,
                  color: Get.isDarkMode
                      ? Constants.colorWhite
                      : Constants.colorBlack,
                ))
          ],
        ),
      ),
      leading: IconButton(
          onPressed: () {
            ThemeService().switchTheme();

            // notifyHelper.displayNotification(
            //   title: "Theme Changed",
            //   body: Get.isDarkMode
            //       ? "Activeted Dark theme"
            //       : "Activeted light theme",
            // );
            // notifyHelper.scheduledNotification();
          },
          icon: Icon(
            Get.isDarkMode ? Icons.sunny : Icons.nightlight,
            color: Get.isDarkMode ? Constants.colorWhite : Constants.colorBlack,
          )),
    );
  }
}

class FirebaseGetData extends StatefulWidget {
  const FirebaseGetData({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _FirebaseGetDataState createState() => _FirebaseGetDataState();
}

final DenemeTaskController denemeTaskController =
    Get.put(DenemeTaskController());

DateTime selectedDate = DateTime.now();

final Stream<QuerySnapshot> _stream = FirebaseFirestore.instance
    .collection('kullanicilar')
    .doc('S4dm6nRToftOjHFySnCM')
    .collection('tasks')
    .snapshots();

class _FirebaseGetDataState extends State<FirebaseGetData> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _stream,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Padding(
              padding: EdgeInsets.only(top: Get.width / 4),
              child: const Center(child: CircularProgressIndicator()),
            );
          }

          return Expanded(
              child: ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              TaskModel ? data = document.data();
                 
              return TaskTile(task:data );
            }).toList(),
          ));
        });
  }

  _showBottomSheet(BuildContext context, TaskModel task) {
    return Get.bottomSheet(BottomSheet(
      onClosing: () {},
      builder: (context) {
        return const Text("");
      },
    ));
  }

  Padding _hasntData() {
    return Padding(
      padding: EdgeInsets.only(top: Get.width / 3),
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TaskTile(
              task: TaskModel(
            title: " Sevgili Soysal",
            note: " I LOVE YOU ",
            date: DateFormat.yMd().format(selectedDate),
            startTime: "startTime",
            endTime: "endTime",
            remind: 10,
            repeat: "5",
            color: 3,
            isCompleted: 0,
          )),
          const Icon(
            Icons.drafts_sharp,
            color: Constants.blusihColor,
            size: 50,
          ),
          Constants.sizedBoxHeight20,
          Text(
            "Kayıtlı bir veri yok ",
            style: titleStyle,
          ),
        ],
      ),
    );
  }
}
