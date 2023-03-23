// ignore_for_file: non_constant_identifier_names, unnecessary_overrides, invalid_return_type_for_catch_error

import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:manger_mission/core/models/task_model.dart';

String? uid = FirebaseAuth.instance.currentUser!.uid;

class DenemeTaskController extends GetxController {
  CollectionReference<Map<String, dynamic>> userCollectionRef =
      FirebaseFirestore.instance
          .collection('kullanicilar')
          .doc(uid)
          .collection('tasks');

  List<TaskModel>? listTask;

  // yeni  verileri veya olan verileri getirmek için  bu fonksiyon kullanılıyor

  Future<List<TaskModel>?> getTask() async {
    final querySnapshot = await userCollectionRef.get();

    listTask =
        querySnapshot.docs.map((e) => TaskModel.fromJson(e.data())).toList();

    log("get task  = $listTask");

    return listTask;
  }

  // yeni  verileri eklemek için  bu fonksiyon kullanılıyor

  Future<void> addTask({TaskModel? task}) {
    //  BAŞARILI ÇALIŞIYOR
    // Call the   Tasks CollectionReference to add a new Tasks

    return userCollectionRef.add(task!.toJson()).then((value) {
      log("Task Added");

      log("Task List  Length :  $listTask ");
    }).catchError((error) => log("Failed to Task: $error"));
  }

  // 1 Task silmek için kullanılan fonksiyon

  Future<void> deleteTask(String? reference) async {
    return await userCollectionRef
        .doc(reference)
        .delete()
        .then((value) => log("Task Deleted"))
        .catchError((error) => log("Failed to Task: $error"));
  }

// bu fonksiyondaki arkadaş bütün verileri silmek içn kullanılıyor

  // Future<void> batchDelete() {
  //   WriteBatch batch = FirebaseFirestore.instance.batch();
  //   return userCollectionRef.get().then((querySnapshot) {
  //     querySnapshot.docs.forEach((document) {
  //       batch.delete(document.reference);
  //     });

  //     return batch.commit();
  //   });
  //}

  // Kaydedilen  verileri çekmek için  bu fonksiyon kullanılıyor
}