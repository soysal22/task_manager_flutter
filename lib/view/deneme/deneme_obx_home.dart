// ignore_for_file: prefer_typing_uninitialized_variables, deprecated_member_use, avoid_print, unnecessary_null_comparison, prefer_is_empty, library_private_types_in_public_api, unused_element, body_might_complete_normally_nullable, unrelated_type_equality_checks
import 'dart:developer';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:manger_mission/core/constants/constants.dart';
import 'package:manger_mission/core/controllers/task_controller.dart';
import 'package:manger_mission/core/models/task_model.dart';
import 'package:manger_mission/core/service/theme_services.dart';
import 'package:manger_mission/core/style/textStyle.dart';
import 'package:manger_mission/core/controllers/auth_controller.dart';
import 'package:manger_mission/core/widgets/my_button.dart';
import 'package:manger_mission/core/widgets/task_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:manger_mission/view/add_page.dart';
import 'package:manger_mission/view/splash_screen.dart';

class DenemeHome extends StatefulWidget {
  const DenemeHome({super.key});

  @override
  State<DenemeHome> createState() => _DenemeHomeState();
}

String? dateString;

class _DenemeHomeState extends State<DenemeHome> {
  String? userName =
      FirebaseAuth.instance.currentUser?.displayName ?? " U.Name ";
  String? profilUrl = FirebaseAuth.instance.currentUser?.photoURL;

  DateTime selectedDate = DateTime.now();

  final TaskController taskController = Get.find();

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
        dateTextStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Constants.colorGrey),
        dayTextStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Constants.colorGrey),
        monthTextStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Constants.colorGrey),
        onDateChange: (date) {
          setState(() {
            selectedDate = date;
            dateString = DateFormat.yMd().format(selectedDate);

            log("selectedDate :$dateString");
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
              Get.to(() => const AddPage());
            },
          ),
        ],
      ),
    );
  }

  AppBar _appBarDesign() {
    return AppBar(
      elevation: 0,
      toolbarHeight: 90,
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
            Container(
              width: 50,
              height: 50,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(50)),
              child: profilUrl == null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.asset(
                        "assets/images/person.png",
                        fit: BoxFit.cover,
                      ),
                    )
                  : const CircleAvatar(
                      radius: 25,
                      backgroundImage: AssetImage("assets/images/person.png")),
            ),
            Constants.sizedBoxWidth10,
            IconButton(
                onPressed: () async {
                  try {
                    log("$userName Kullanıcısı Çıkış Yaptı");
                    //Future.delayed(const Duration(milliseconds: 1000));
                    Get.to(() => const SplashScreen());
                    await sigInOutWithGoogle();
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

final TaskController taskController = Get.find();

DateTime selectedDate = DateTime.now();
String? deleteId;
int? newCompleted;
List<TaskModel>? gelenTask;

//List<TaskModel>? gelenTask;
List<DocumentSnapshot>? listOfDocumentSnap;

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

          if (snapshot.connectionState == ConnectionState.none) {
            return const Placeholder();
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Padding(
              padding: EdgeInsets.only(top: Get.width / 4),
              child: const Center(child: CircularProgressIndicator()),
            );
          }

          log("uid : $uid");

          try {
            listOfDocumentSnap = snapshot.data.docs;
            //gelen query snapshot verilerini document snopshot a çevirdik
            // gelen dosyayı kendi modeline me göre çevirip listeliyorum
            gelenTask = listOfDocumentSnap!
                .map(
                    (e) => TaskModel.fromJson(e.data() as Map<String, dynamic>))
                .toList();
            log("gelen Task  length : ${gelenTask?.length}");
          } catch (e) {
            log("error :  $e");
          }

          log("gelen deneme Task  length : ${taskController.listTask.length}");

          return _designHomeListView();
        });
  }

  _designHomeListView() {
    return Expanded(
        child: taskController.listTask.length == 0 ||
                taskController.listTask.length == null
            ? _hasntData()
            : FutureBuilder(
                builder: (context, snapshot) {
                  return ListView.builder(
                      itemCount: gelenTask?.length,
                      itemBuilder: (context, index) {
                        TaskModel? task = taskController.listTask[index];
                        //   log("Task Date : ${ taskController.listTask.toString() ?? "date yok "} ");
                        return GestureDetector(
                            onTap: () {
                              _showBottomSheet(context, task);

                              deleteId =
                                  listOfDocumentSnap?[index].reference.id;
                            },
                            child: TaskTile(task: task));
                      });
                },
              ));
  }

/*  ListView.builder(
                    itemCount: gelenTask?.length,
                    itemBuilder: (context, index) {
                      TaskModel? task = gelenTask?[index];
                      log(task?.toJson().toString() ?? "task empty");
                      return AnimationConfiguration.staggeredList(
                          position: index,
                          child: FadeInAnimation(
                            curve: Curves.easeInOut,
                            child: GestureDetector(
                              onTap: () {
                                _showBottomSheet(context, task);
                                deleteId =
                                    listOfDocumentSnap?[index].reference.id;
                              },
                              /** child: Slidable(
                            // Specify a key if the Slidable is dismissible.
                            key: const ValueKey(0),

                            // The start action pane is the one at the left or the top side.
                            startActionPane: ActionPane(
                              // A motion is a widget used to control how the pane animates.
                              motion: const ScrollMotion(),

                              // A pane can dismiss the Slidable.
                              dismissible:
                                  DismissiblePane(onDismissed: () {}),

                              // All actions are defined in the children parameter.
                              children: [
                                // A SlidableAction can have an icon and/or a label.
                                SlidableAction(
                                  onPressed: (context) async {
                                    await denemeTaskController
                                        .deleteTask(deleteId);
                                  },
                                  backgroundColor: const Color(0xFFFE4A49),
                                  foregroundColor: Colors.white,
                                  icon: Icons.delete,
                                  label: 'Delete',
                                ),
                              ],
                            ), */

                              child: TaskTile(task: task),
                            ),
                          ));
                    }), */

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

  _showBottomSheet(BuildContext? context, TaskModel? task) {
    return Get.bottomSheet(Container(
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
                    Get.back();
                    task.isCompleted = 1;
                    await taskController.taskCompleted(
                        deleteId, task.isCompleted);

                    log("isCompleted son  hali : ${task.isCompleted}");
                  },
                  color: Constants.primaryColor),
          Constants.sizedBoxHeight10,
          // Delete Button
          _bottomSheetButton(
              context: context,
              label: "Delete",
              onTap: () async {
                Get.back();
                await taskController.deleteTask(deleteId);
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
}
