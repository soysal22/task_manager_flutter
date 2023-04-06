import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:manger_mission/core/constants/constants.dart';
import 'package:manger_mission/core/models/task_model.dart';
import 'package:manger_mission/view/detail_page.dart';

class TaskTile extends StatelessWidget {
  final TaskModel? task;
  const TaskTile({required this.task, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(top: 12),
      child: Container(
        padding: const EdgeInsets.all(16),
        //  width: SizeConfig.screenWidth * 0.78,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: _getBacgroundColor(task?.color ?? 0),
        ),
        child: Row(children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task?.title ?? "title yok ",
                  style: GoogleFonts.lato(
                    textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Constants.colorWhite),
                  ),
                ),
                Constants.sizedBoxHeight12,
                _rowTimeTexts(),
                Constants.sizedBoxHeight12,
                Text(
                  task?.note ?? "note yok ",
                  style: GoogleFonts.lato(
                    textStyle:
                        TextStyle(fontSize: 15, color: Constants.colorGrey100),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child: Column(
            children: [
              TextButton(
                style: TextButton.styleFrom(
                    side: const BorderSide(
                        color: Constants.colorWhite, width: 2)),
                onPressed: () {
                  Get.to(() => DetailPage(
                        task: task!,
                      ));
                },
                child: Text(
                  "Detail Page",
                  style: GoogleFonts.lato(
                    textStyle:
                        TextStyle(fontSize: 15, color: Constants.colorGrey100),
                  ),
                ),
              )
            ],
          )),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            height: 60,
            width: 0.5,
            color: Constants.colorGrey200?.withOpacity(0.6),
          ),
          RotatedBox(
            quarterTurns: 3,
            child: Text(
              task?.isCompleted == 1 ? "COMPLETED" : "TODO",
              style: GoogleFonts.lato(
                textStyle: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Constants.colorWhite),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  Row _rowTimeTexts() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.access_time_rounded,
          color: Constants.colorGrey200,
          size: 18,
        ),
        Constants.sizedBoxWidth4,
        Text(
          "${task?.startTime} - ${task?.endTime}",
          style: GoogleFonts.lato(
            textStyle: TextStyle(fontSize: 13, color: Constants.colorGrey100),
          ),
        ),
      ],
    );
  }

  _getBacgroundColor(int no) {
    switch (no) {
      case 0:
        return Constants.blusihColor;
      case 1:
        return Constants.pinkColor;
      case 2:
        return Constants.colorYellow;
      default:
        return Constants.blusihColor;
    }
  }
}
