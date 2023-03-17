// ignore_for_file: prefer_typing_uninitialized_variables, deprecated_member_use, avoid_print
import 'dart:developer';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:manger_mission/core/constants/constants.dart';
import 'package:manger_mission/core/controllers/task_controller.dart';
import 'package:manger_mission/core/service/notification_service.dart';
import 'package:manger_mission/core/service/theme_services.dart';
import 'package:manger_mission/core/themes/themes.dart';
import 'package:manger_mission/core/users/google_sign_in.dart';
import 'package:manger_mission/core/widgets/my_button.dart';
import 'package:manger_mission/core/widgets/task_tile.dart';
import 'package:manger_mission/view/add_task_page.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:manger_mission/view/splash_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var notifyHelper = NotifyHelper();

  DateTime selectedDate = DateTime.now();
  final TaskController taskController = Get.put(TaskController());

  // @override
  // void initState() {
  //   super.initState();
  //   notifyHelper.initializeNotification();
  //   notifyHelper.requestIOSPermissions();
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      key: GlobalKey(),
      backgroundColor: context.theme.backgroundColor,
      extendBody: true,
      appBar: _appBarDesign(),
      body: Column(
        children: [
          _addTaskBar(),
          _addDateBar(),
          _showTask(),
        ],
      ),
    ));
  }

  _showTask() {
    return Expanded(child: Obx(
      () {
        return ListView.builder(
          itemCount: taskController.taskList.length,
          itemBuilder: (_, index) {
            print(taskController.taskList.length);
            return AnimationConfiguration.staggeredList(
                position: index,
                child: SlideAnimation(
                    child: FadeInAnimation(
                        child: Row(
                  children: [
                    GestureDetector(
                        onTap: () {
                          print("tapped");
                        },
                        child: TaskTile(taskController.taskList[index]))
                  ],
                ))));
          },
        );
      },
    ));
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
            onPressed: () async {
              await Get.to(() => const AddTaskPage());
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
              "Welcome ${FirebaseAuth.instance.currentUser?.displayName!}",
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
                  sigInOutWithGoogle();
                  log("${FirebaseAuth.instance.currentUser?.displayName} Kullanıcısı Çıkış Yaptı");
                  Get.to(() => const SplashScreen());
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
