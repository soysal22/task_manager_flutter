// ignore_for_file: non_constant_identifier_names, unnecessary_overrides

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:manger_mission/core/models/task_model.dart';

class TaskController extends GetxController {
  @override
  void onReady() {
    super.onReady();
  }

  List taskList = [].obs;

  // verileri kaydetmek için  bu fonksiyon kullanılıyor

  AddTask({TaskModel? task}) {
    FirebaseFirestore.instance;

    log("Task a Created ");

    log("task listin uzunuluğu  : ${taskList.length}");
    log("task in  son hali : $task");

    log("task listin son hali : $taskList");
    return taskList;
  }

  // Kaydedilen  verileri çekmek için  bu fonksiyon kullanılıyor

  getTask() {}
}
