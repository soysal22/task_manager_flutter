// ignore_for_file: non_constant_identifier_names, unnecessary_overrides

import 'package:get/get.dart';
import 'package:manger_mission/core/models/add_task_model.dart';

class TaskController extends GetxController {
  @override
  void onReady() {
    super.onReady();
  }

  AddTaskModel? AddTask({AddTaskModel? task}) {
    return task;
  }
}
