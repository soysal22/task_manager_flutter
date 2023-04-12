// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:manger_mission/core/constants/constants.dart';
import 'package:manger_mission/core/style/textStyle.dart';

class InputField extends StatefulWidget {
  final String labelText;
  final String hintText;
  final TextEditingController? controller;
  final Widget? widget;
  final TextInputType? keyboardType;
  final String? Function(String?)? validate;
  final bool ObscureText;

  const InputField({
    super.key,
    required this.labelText,
    required this.hintText,
    this.controller,
    this.widget,
    this.validate,
    this.keyboardType = TextInputType.name,
    this.ObscureText = false,
  });

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: Constants.borderRadius15,
          side: const BorderSide(width: 2, color: Constants.colorGrey)),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 5),
        child: TextFormField(
          validator: widget.validate,
          keyboardType: widget.keyboardType,
          autofocus: false,
          obscureText: widget.ObscureText,
          controller: widget.controller,
          decoration: InputDecoration(
              contentPadding: Constants.paddingLeft20,
              border: InputBorder.none,
              labelText: widget.labelText,
              hintText: widget.hintText,
              hintStyle: subtitleStyle,
              suffixIcon: widget.widget,
              isDense: true),
        ),
      ),
    );
  }
}
