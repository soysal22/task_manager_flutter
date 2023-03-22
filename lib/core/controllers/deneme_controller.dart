// ignore_for_file: non_constant_identifier_names, unnecessary_overrides

import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:manger_mission/core/models/task_model.dart';

class DenemeTaskController extends GetxController {
  CollectionReference<Map<String, dynamic>> userCollectionRef =
      FirebaseFirestore.instance
          .collection('kullanicilar')
          .doc('S4dm6nRToftOjHFySnCM')
          .collection('tasks');

  @override
  void onReady() {
    super.onReady();
  }

  // yeni  verileri eklemek için  bu fonksiyon kullanılıyor

  Future<void> AddTask({TaskModel? task}) {
    //  BAŞARILI ÇALIŞIYOR
    // Call the   Tasks CollectionReference to add a new Tasks

    return userCollectionRef
        .add(task!.toJson())
        .then((value) => log("Task Added"))
        .catchError((error) => log("Failed to Task: $error"));
  }

  // Kaydedilen  verileri çekmek için  bu fonksiyon kullanılıyor
  List<TaskModel>? getList;

  Future<List<TaskModel>?> getTask() async {
    final querySnapshot = await userCollectionRef.get();
    getList =
        querySnapshot.docs.map((e) => TaskModel.fromJson(e.data())).toList();
    log(getList.toString());
    return getList;
  }
}
