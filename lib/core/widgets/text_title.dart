import 'package:flutter/material.dart';
import 'package:manger_mission/core/constants/constants.dart';

class TextTitle extends StatelessWidget {
  const TextTitle({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context)
          .textTheme
          .headlineMedium
          ?.copyWith(color: Constants.colorBlack, fontWeight: FontWeight.bold),
    );
  }
}
