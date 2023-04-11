import 'package:flutter/material.dart';
import 'package:manger_mission/core/constants/constants.dart';

class GreyText extends StatelessWidget {
  const GreyText({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(title,
        style: Theme.of(context)
            .textTheme
            .titleLarge
            ?.copyWith(color: Constants.colorGrey, fontSize: 20));
  }
}
