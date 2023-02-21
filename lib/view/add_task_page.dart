// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manger_mission/core/constants/constants.dart';

class AddTaskPage extends StatelessWidget {
  const AddTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _appBarDesign(),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleAndTextfield(title: "Title", hintText: "Write a title")
            ],
          ),
        ),
      ),
    );
  }

  AppBar _appBarDesign() {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Icon(Icons.arrow_back_ios_new)),
      centerTitle: true,
      title: Text("Add A Task"),
    );
  }
}

class TitleAndTextfield extends StatelessWidget {
  TitleAndTextfield({Key? key, required this.title, required this.hintText})
      : super(key: key);
  String title;

  String hintText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headline6?.copyWith(
              color: Constants.colorBlack, fontWeight: FontWeight.bold),
        ),
        Constants.sizedBoxHeight5,
        TextFormField(
          decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: Constants.borderRadius15,
                borderSide: const BorderSide()),
            hintText: hintText,
            contentPadding: Constants.paddingAll10,
            hintTextDirection: TextDirection.ltr,
          ),
        )
      ],
    );
  }
}
