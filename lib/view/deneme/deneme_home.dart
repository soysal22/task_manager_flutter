// ignore_for_file: prefer_typing_uninitialized_variables, deprecated_member_use, avoid_print, unnecessary_null_comparison, prefer_is_empty, library_private_types_in_public_api
import 'dart:developer';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:manger_mission/core/constants/constants.dart';
import 'package:manger_mission/core/controllers/deneme_controller.dart';
import 'package:manger_mission/core/models/task_model.dart';
import 'package:manger_mission/core/service/theme_services.dart';
import 'package:manger_mission/core/themes/themes.dart';
import 'package:manger_mission/core/controllers/auth_controller.dart';
import 'package:manger_mission/core/widgets/my_button.dart';
import 'package:manger_mission/core/widgets/task_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:manger_mission/view/deneme/deneme_add.dart';
import 'package:manger_mission/view/splash_screen.dart';

class DenemeHome extends StatefulWidget {
  const DenemeHome({super.key});

  @override
  State<DenemeHome> createState() => _DenemeHomeState();
}

class _DenemeHomeState extends State<DenemeHome> {
  String? userName =
      AuthController.instance.auth.currentUser?.displayName ?? "empty";
  DateTime selectedDate = DateTime.now();

  final DenemeTaskController taskController = Get.put(DenemeTaskController());

  //  var notifyHelper = NotifyHelper();

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

          // Firebase datasının  geleceği yer
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
              "Welcome $userName",
              style: titleStyle,
            ),
            Constants.sizedBoxWidth10,
            const CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage("assets/images/person.png"),
            ),
            Constants.sizedBoxWidth10,
            IconButton(
                onPressed: () async {
                  try {
                    await sigInOutWithGoogle().then((value) {
                      log("$userName Kullanıcısı Çıkış Yaptı");
                      return Get.to(() => const SplashScreen());
                    });
                  } catch (e) {
                    print(e);
                  }
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
  _FirebaseGetDataState createState() => _FirebaseGetDataState();
}

final DenemeTaskController denemeTaskController =
    Get.put(DenemeTaskController());

DateTime selectedDate = DateTime.now();

String? deleteId;
int? newCompleted;
List<DocumentSnapshot>? listOfDocumentSnap;
List<TaskModel>? gelenTask;

String? uid = FirebaseAuth.instance.currentUser?.uid;

final Stream<QuerySnapshot> _stream = FirebaseFirestore.instance
    .collection('kullanicilar')
    .doc(uid)
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
          log(snapshot.connectionState.toString());

          if (snapshot.connectionState == ConnectionState.waiting) {
            Padding(
              padding: EdgeInsets.only(top: Get.width / 4),
              child: const Center(child: CircularProgressIndicator()),
            );
          }

          log("uid : $uid");

          try {
            //gelen query snapshot verilerini document snopshot a çevirdik

            listOfDocumentSnap = snapshot.data?.docs;

            // gelen dosyayı kendi modeline me göre çevirip listeliyorum
            gelenTask = listOfDocumentSnap!
                .map(
                    (e) => TaskModel.fromJson(e.data() as Map<String, dynamic>))
                .toList();
          } catch (e) {
            log("error :  $e");
          }
          //  log("Tasks  length : ${listOfDocumentSnap.length}");
          // log("get List length : ${denemeTaskController.listTask?.length}");

          log("gelen Task  length : ${gelenTask?.length}");

          return Expanded(
            child: gelenTask?.length == 0
                ? _hasntData()
                : ListView.builder(
                    itemCount: gelenTask?.length,
                    itemBuilder: (context, index) {
                      TaskModel? task = gelenTask?[index];
                      log(task?.toJson().toString() ?? "task empty");
                      //if (task?.date == DateFormat.yMd().format(selectedDate))

                      return AnimationConfiguration.staggeredList(
                          position: index,
                          child: FadeInAnimation(
                              curve: Curves.easeInOut,
                              child: Row(
                                children: [
                                  GestureDetector(
                                      onTap: () {
                                        _showBottomSheet(context, task);
                                        deleteId = listOfDocumentSnap?[index]
                                            .reference
                                            .id;
                                        setState(() {
                                          newCompleted =
                                              gelenTask?[index].isCompleted;
                                        });
                                      },
                                      child: TaskTile(task: task)),
                                ],
                              )));
                    }),
          );
        });
  }

  // ignore: slash_for_doc_comments
  /** ListView.builder(
            itemCount: denemeTaskController.getTask,
            itemBuilder: (context, index) {
              // var gelList = denemeTaskController.getList;
              return GestureDetector(
                  onDoubleTap: () async {
                    log("Task refernece ${listOfDocumentSnap[index] // o dökümanın index ile hangisi olduğunu tutuyoruz zaten onun için delete fonk sktif ettikten sonra iş bitiyor
                        .reference }");
                    await listOfDocumentSnap[
                            index] // o dökümanın index ile hangisi olduğunu tutuyoruz zaten onun için delete fonk sktif ettikten sonra iş bitiyor
                        .reference
                        .delete();
                  },
                  onTap: () {
                    _showBottomSheet(
                        context, denemeTaskController.listTask?[index]);
                  },
                  child: TaskTile(task: denemeTaskController.listTask?[index]));
            },
          )) */

  _showBottomSheet(BuildContext? context, TaskModel? task) {
    return Get.bottomSheet(
      
      Container(
      padding: const EdgeInsets.only(top: 4),
      height: task?.isCompleted == 1 ? Get.height * 0.24 : Get.height * 0.32,
      color: Get.isDarkMode ? Constants.darkGreyColor : Constants.colorWhite,
      child: Column(
        children: [
          _dividerBottomSheet(),
          const Spacer(),

          // Completed  Button
          task?.isCompleted == 1
              ? Container()
              : _bottomSheetButton(
                  context: context,
                  label: "Task Completed",
                  onTap: () async {
                    log("isCompleted ilk hali : ${task!.isCompleted}");

                    task.isCompleted = 1;
                    await denemeTaskController
                        .taskCompleted(deleteId, task.isCompleted)
                        .then((value) {
                      Get.back();
                      log("isCompleted son  hali : ${task.isCompleted}");
                    });
                  },
                  color: Constants.primaryColor),
          Constants.sizedBoxHeight10,
          // Delete Button
          _bottomSheetButton(
              context: context,
              label: "Delete",
              onTap: () async {
                await denemeTaskController.deleteTask(deleteId).then((value) {
                  Get.back();
                });
              },
              color: Constants.colorRed),
          Constants.sizedBoxHeight20,
          // Close  Button
          _bottomSheetButton(
            context: context,
            label: "Close",
            isClose: true,
            onTap: () {
              Get.back();
            },
          ),
          Constants.sizedBoxHeight20,
        ],
      ),
    ));
  }

  Container _dividerBottomSheet() {
    return Container(
      height: 6,
      width: 120,
      decoration: BoxDecoration(
        borderRadius: Constants.borderRadius10,
        color: Get.isDarkMode ? Constants.colorGrey : Constants.darkHeaderColor,
      ),
    );
  }

  _bottomSheetButton(
      {BuildContext? context,
      required String label,
      required Function() onTap,
      Color? color,
      bool isClose = false}) {
    return SizedBox(
        width: Get.width * 0.9,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(15),
              backgroundColor: isClose == true
                  ? Get.isDarkMode
                      ? Constants.colorBlack
                      : Constants.colorWhite
                  : color,
              shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 2,
                    color: isClose == true ? Constants.colorGrey : color!,
                  ),
                  borderRadius: Constants.borderRadius20)),
          onPressed: onTap,
          child: Center(
            child: Text(label, style: titleStyle),
          ),
        ));
  }

  Padding _hasntData() {
    return Padding(
      padding: EdgeInsets.only(top: Get.width / 3),
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.drafts_sharp,
            color: Constants.blusihColor,
            size: 50,
          ),
          Constants.sizedBoxHeight20,
          Text(
            "Kayıtlı bir Task yok ",
            style: titleStyle,
          ),
        ],
      ),
    );
  }
}
