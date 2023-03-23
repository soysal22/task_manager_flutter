// ignore_for_file: must_be_immutable, use_build_context_synchronously, avoid_print, deprecated_member_use
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:manger_mission/core/constants/constants.dart';
import 'package:manger_mission/core/controllers/deneme_controller.dart';
import 'package:manger_mission/core/models/task_model.dart';
import 'package:manger_mission/core/themes/themes.dart';
import 'package:manger_mission/core/widgets/my_button.dart';
import 'package:manger_mission/core/widgets/my_input_field.dart';

class DenemeAddPage extends StatefulWidget {
  const DenemeAddPage({super.key});

  @override
  State<DenemeAddPage> createState() => _DenemeAddPageState();
}

class _DenemeAddPageState extends State<DenemeAddPage> {
  DateTime selectedDate = DateTime.now();
  String endTime = "09,30 PM";
  String startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  int selectedRemind = 5;
  int selectedColor = 0;
  List<int> remindList = [5, 10, 20, 25];
  String selectedRepeat = "None";
  List<String> repeatList = ["None", "Daily", "Weekly", "Monthly"];

  final DenemeTaskController taskController = Get.put(DenemeTaskController());

  final TextEditingController? titleEditingController = TextEditingController();
  final TextEditingController? noteEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: _appBarDesign(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Add Task",
                style: headingStyle,
              ),
              // title is Here
              MyInputField(
                title: "Title",
                hintText: "Enter Title Here",
                controller: titleEditingController,
              ),
              // note is Here
              MyInputField(
                title: "Note",
                hintText: "Enter Note Here",
                controller: noteEditingController,
              ),
              _dateBar(),
              _timeBar(),
              _remindBar(),
              _repeatBar(),
              _colorPalette(),
            ],
          ),
        ),
      ),
    );
  }

  _validate() async {
    if (titleEditingController!.text.isNotEmpty &&
        noteEditingController!.text.isNotEmpty) {
      // add to database    //  buraya yazdıklarımmızı kaydedeceğiz
      await _addTaskDb();
    } else if (titleEditingController!.text.isEmpty ||
        noteEditingController!.text.isEmpty) {
      Get.snackbar(
          snackPosition: SnackPosition.TOP,
          icon: const Icon(
            Icons.warning_amber_outlined,
            color: Constants.pinkColor,
            size: 30,
          ),
          colorText: Constants.pinkColor,
          backgroundColor: Constants.colorWhite,
          "Problem var",
          "Lütfen Title veya Note kısmını kontrol ediniz");
    }
  }

  _addTaskDb() async {
    await taskController
        .addTask(
            task: TaskModel(
          title: titleEditingController?.text,
          note: noteEditingController?.text,
          date: DateFormat.yMd().format(selectedDate),
          startTime: startTime,
          endTime: endTime,
          remind: selectedRemind,
          repeat: selectedRepeat,
          color: selectedColor,
          isCompleted: 0,
        ))
        .then((value) => Get.back());
  }

  Padding _colorPalette() {
    return Padding(
      padding: const EdgeInsets.only(top: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Color",
                style: titleStyle,
              ),
              Constants.sizedBoxHeight8,
              Wrap(
                spacing: 8,
                children: List<Widget>.generate(3, (index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedColor = index;
                      });
                    },
                    child: CircleAvatar(
                      radius: 14,
                      backgroundColor: index == 0
                          ? Constants.primaryColor
                          : index == 1
                              ? Constants.pinkColor
                              : Constants.colorYellow,
                      child: selectedColor == index
                          ? const Icon(
                              Icons.done,
                              color: Constants.colorWhite,
                              size: 16,
                            )
                          : Constants.sizedBoxHeight0,
                    ),
                  );
                }),
              ),
            ],
          ),
          MyButton(
            title: "Create Task",
            onPressed: () async {
              await _validate();
            },
          )
        ],
      ),
    );
  }

  MyInputField _repeatBar() {
    return MyInputField(
      title: "Repeat",
      hintText: selectedRepeat,
      widget: DropdownButton(
        icon: const Icon(
          Icons.keyboard_arrow_down_outlined,
          color: Constants.colorGrey,
        ),
        iconSize: 32,
        elevation: 5,
        style: subtitleStyle,
        underline: Constants.sizedBoxHeight0,
        items: repeatList.map<DropdownMenuItem<String>>((String? value) {
          return DropdownMenuItem<String>(
              value: value, child: Text(value ?? "empty"));
        }).toList(),
        onChanged: (newValue) {
          setState(() {
            selectedRepeat = newValue ?? "empty";
            log(selectedRepeat);
          });
        },
      ),
    );
  }

  MyInputField _remindBar() {
    return MyInputField(
      title: "Remind",
      hintText: "$selectedRemind  minute early",
      widget: DropdownButton(
        icon: const Icon(
          Icons.keyboard_arrow_down_outlined,
          color: Constants.colorGrey,
        ),
        iconSize: 32,
        elevation: 5,
        style: subtitleStyle,
        underline: Container(
          height: 0,
        ),
        items: remindList.map<DropdownMenuItem<String>>((int value) {
          return DropdownMenuItem<String>(
              value: value.toString(), child: Text(value.toString()));
        }).toList(),
        onChanged: (newValue) {
          setState(() {
            selectedRemind = int.parse(newValue ?? "empty");

            log(selectedRemind.toString());
          });
        },
      ),
    );
  }

  Row _timeBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: MyInputField(
            title: "Start Time ",
            hintText: startTime,
            widget: IconButton(
                onPressed: () {
                  _getTimeFromUser(isStartTime: true);
                },
                icon: const Icon(Icons.access_time_sharp,
                    color: Constants.colorGrey)),
          ),
        ),
        Constants.sizedBoxWidth10,
        Expanded(
            child: MyInputField(
          title: "End Time ",
          hintText: endTime,
          widget: IconButton(
              onPressed: () {
                _getTimeFromUser(isStartTime: false);
              },
              icon: const Icon(Icons.access_time_sharp,
                  color: Constants.colorGrey)),
        )),
      ],
    );
  }

  MyInputField _dateBar() {
    return MyInputField(
      title: "Date",
      hintText: DateFormat.yMMMMd().format(selectedDate),
      widget: IconButton(
          onPressed: () {
            _getDateTimeFromUSer();
          },
          icon: const Icon(Icons.calendar_month_outlined,
              color: Constants.colorGrey)),
    );
  }

  AppBar _appBarDesign(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: context.theme.backgroundColor,
      automaticallyImplyLeading: false,
      title: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
            CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage(
                "assets/images/person.png",
              ),
            ),
          ],
        ),
      ),
      leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Get.isDarkMode ? Constants.colorWhite : Constants.colorBlack,
          )),
    );
  }

  _getDateTimeFromUSer() async {
    DateTime? pickerDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015),
        lastDate: DateTime(2120));

    if (pickerDate != null) {
      setState(() {
        selectedDate = pickerDate;
        log(selectedDate.toString());
      });
    } else {
      log("It is null or Something Wrong");
    }
  }

  _getTimeFromUser({required bool isStartTime}) async {
    var pickerTime = await _showPickerTime();

    String formatedTime = pickerTime.format(context);

    if (pickerTime == null) {
      log("Time is Canceled");
    } else if (isStartTime == true) {
      setState(() {
        startTime = formatedTime;
        log("End Time: $startTime");
      });
    } else if (isStartTime == false) {
      setState(() {
        endTime = formatedTime;
        log("End Time: $endTime");
      });
    }
  }

  _showPickerTime() {
    return showTimePicker(
        initialEntryMode: TimePickerEntryMode.input,
        context: context,
        initialTime: TimeOfDay(
          // saat 10:30 AM  write
          hour: int.parse(startTime.split(":")[0]),
          minute: int.parse(startTime.split(":")[1].split(" ")[0]),
          // sondaki boşluk AM ile PM in saat ile arasinda kalan boşluk içindir
        ));
  }
}
