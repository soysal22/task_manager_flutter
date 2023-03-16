// ignore_for_file: non_constant_identifier_names, unnecessary_overrides

import 'package:get/get.dart';
import 'package:manger_mission/core/models/task_model.dart';

class TaskController extends GetxController {
  @override
  void onReady() {
    super.onReady();
  }

  List taskList = [].obs;
  List AddTask({TaskModel? task}) {
    taskList.map((data) => TaskModel.fromJson(data)).toList();

    return taskList;
  }
}
