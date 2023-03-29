// ignore_for_file: non_constant_identifier_names, unnecessary_overrides, invalid_return_type_for_catch_error

import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:manger_mission/core/models/auth__model.dart';
import 'package:manger_mission/core/models/task_model.dart';

String? uid = FirebaseAuth.instance.currentUser!.uid;

class DenemeTaskController extends GetxController {
  CollectionReference<Map<String, dynamic>> userCollectionRef =
      FirebaseFirestore.instance
          .collection('kullanicilar')
          .doc(uid)
          .collection('tasks');

  List listTask = [].obs;

  // yeni  verileri veya olan verileri getirmek için  bu fonksiyon kullanılıyor

  Future<List> getTask() async {
    final querySnapshot = await userCollectionRef.get();

    listTask =
        querySnapshot.docs.map((e) => TaskModel.fromJson(e.data())).toList();

    log("get task  = $listTask");

    return listTask;
  }

  // yeni  verileri eklemek için  bu fonksiyon kullanılıyor

  Future<void> addTask({TaskModel? task}) async {
    //  BAŞARILI ÇALIŞIYOR
    // Call the   Tasks CollectionReference to add a new Tasks

    return userCollectionRef.add(task!.toJson()).then((value) {
      log("Task Added");
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

  Future taskCompleted(String? reference, int? newCompleted) async {
    log("newCompleted yeni hali :  $newCompleted");
    return await userCollectionRef
        .doc(reference)
        .update(
          {'isCompleted': newCompleted},
          // Set({}) , bundan sonra set opstionsu kullanıyoruz ..
          // SetOptions(merge: true)
          // update ({'isCompleted': newCompleted}) bu şekilde yazmamız yeterli olur
          // set yerine update fonksiyonunuda kullanabiliriz
          // merge kodu sayesinde sadece değiştirmek istediğimiz yeri değiştirip diğer yerlerin sabit kalmasıısağlayabiliriz
        )
        .then((value) => log("Task  Completed"))
        .catchError((error) => log("Failed to Task: $error"));
  }

  // kullanici kaydı

  Future<void> addUser({AuthModel? authModel}) async {
    CollectionReference<Map<String, dynamic>> userRef =
        FirebaseFirestore.instance.collection('newUser');

    return userRef.add(authModel!.toJson()).then((value) {
      log("User Added");
    }).catchError((error) => log("Failed to User: $error"));
  }
}
