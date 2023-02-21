import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manger_mission/view/add_task_page.dart';
import 'package:manger_mission/view/home_page.dart';
import 'package:manger_mission/view/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AddTaskPage(),
    );
  }
}
