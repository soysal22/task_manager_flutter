import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manger_mission/core/constants/constants.dart';
import 'package:manger_mission/core/themes/themes.dart';

class MyInputField extends StatelessWidget {
  final String title;
  final String hintText;
  final TextEditingController? controller;
  final Widget? widget;

  const MyInputField(
      {super.key,
      required this.title,
      required this.hintText,
      this.controller,
      this.widget});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: titleStyle,
          ),
          Container(
            margin: const EdgeInsets.only(top: 8),
            padding: const EdgeInsets.only(left: 14),
            height: 50, //Get.width / 8
            width: Get.width,
            decoration: BoxDecoration(
              border: Border.all(color: Constants.colorGrey, width: 1.0),
              borderRadius: Constants.borderRadius15,
            ),
            child: Row(
              children: [
                Expanded(
                    child: TextFormField(
                  readOnly: widget == null ? false : true,
                  autofocus: false,
                  cursorColor:
                      Get.isDarkMode ? Colors.grey[100] : Colors.grey[600],
                  controller: controller,
                  style: subtitleStyle,
                  decoration: InputDecoration(
                    hintText: hintText,
                    hintStyle: subtitleStyle,
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            width: 0,
                            color: context.theme.colorScheme.background)),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            width: 0,
                            color: context.theme.colorScheme.background)),
                  ),
                )),
                widget == null
                    ? Container()
                    : Container(
                        child: widget,
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
