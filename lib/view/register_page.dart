import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:manger_mission/core/constants/constants.dart';
import 'package:manger_mission/core/validates/validation_mixin.dart';
import 'package:manger_mission/view/login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

TextEditingController registerNameController = TextEditingController();

TextEditingController registerEmailController = TextEditingController();

TextEditingController registerPasswordController = TextEditingController();
bool registerObscureText = true;

final registerFormKey = GlobalKey<FormState>();

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _appBarDesign(),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: registerFormKey,
            child: Column(
              children: [
                _nameTextField(),
                Constants.sizedBoxHeight20,
                _emailTextfield(),
                Constants.sizedBoxHeight20,
                _passwordTextfield(),
                Constants.sizedBoxHeight20,
                _savedButton(context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  CupertinoButton _savedButton(BuildContext context) {
    return CupertinoButton.filled(
      onPressed: () async {
        if (registerFormKey.currentState?.validate() == true) {
          Get.to(
            duration: const Duration(seconds: 1),
            curve: Curves.bounceOut,
            const LoginPage(),
          );
        }
      },
      child: _buttonText(context),
    );
  }

  Text _buttonText(BuildContext context) {
    return Text(
      "Save",
      style: Theme.of(context).textTheme.subtitle1?.copyWith(
          color: Constants.colorWhite,
          fontSize: 25,
          fontWeight: FontWeight.bold),
    );
  }

  Card _nameTextField() {
    return Card(
      child: TextFormField(
        validator: ValidationMixin().validateName,
        keyboardType: TextInputType.name,
        controller: registerNameController,
        decoration: const InputDecoration(
            hintText: "Please Write to a Name Ex: ibrahim ",
            suffixIcon: Icon(
              Icons.email_sharp,
              size: 30,
            ),
            labelText: "Name"),
      ),
    );
  }

  Card _emailTextfield() {
    return Card(
      child: TextFormField(
        validator: ValidationMixin().validateEmailName,
        keyboardType: TextInputType.emailAddress,
        controller: registerEmailController,
        decoration: const InputDecoration(
            hintText: "Please Write to an Email Ex: adasd@dada ",
            suffixIcon: Icon(
              Icons.email_sharp,
              size: 30,
            ),
            labelText: "Email"),
      ),
    );
  }

  Card _passwordTextfield() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Center(
          child: TextFormField(
            validator: ValidationMixin().validatePassword,
            keyboardType: TextInputType.name,
            obscureText: registerObscureText,
            controller: registerPasswordController,
            decoration: InputDecoration(
                hintText: "Please Write to a Password ",
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      registerObscureText = !registerObscureText;
                      log("obscureText in değeri  :  ${registerObscureText}");
                    });
                  },
                  child: registerObscureText == true
                      ? const Icon(
                          Icons.remove_red_eye,
                          size: 30,
                        )
                      : const Icon(
                          Icons.close_rounded,
                          size: 30,
                        ),
                ),
                labelText: "Passsword "),
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
          child: const Icon(Icons.arrow_back_ios_new)),
      centerTitle: true,
      title: const Text("Register Page"),
    );
  }
}
