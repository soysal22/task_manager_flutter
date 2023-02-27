import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manger_mission/core/constants/constants.dart';
import 'package:manger_mission/core/service/theme_services.dart';
import 'package:manger_mission/view/add_task_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: GestureDetector(
            onTap: () {
              ThemeService().switchTheme();
            },
            child: Icon(Icons.sunny)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: Constants.borderRadius10),
                        padding: const EdgeInsets.only(
                            top: 15, bottom: 15, left: 20, right: 20)),
                    onPressed: () {
                      Get.to(AddTaskPage());
                    },
                    child: Center(child: Text("+ Add Task")))
              ],
            )
          ],
        ),
      ),
    ));
  }
}
