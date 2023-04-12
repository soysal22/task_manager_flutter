import 'package:flutter/material.dart';
import 'package:manger_mission/core/constants/constants.dart';
import 'package:manger_mission/core/style/textStyle.dart';

class MyButton extends StatelessWidget {
  final String? title;
  final Function()? onPressed;
  const MyButton({super.key, required this.title, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Constants.primaryColor,
            shape:
                RoundedRectangleBorder(borderRadius: Constants.borderRadius10),
            padding: const EdgeInsets.all(25)),
        onPressed: onPressed,
        child: Center(
            child: Text(
          title ?? "empty",
          style: titleStyleWhite,
        )));
  }
}
