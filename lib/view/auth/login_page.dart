// ignore_for_file: avoid_print, unrelated_type_equality_checks, unused_element, unnecessary_brace_in_string_interps, non_constant_identifier_names, deprecated_member_use

import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manger_mission/core/constants/constants.dart';
import 'package:manger_mission/core/controllers/auth_controller.dart';
import 'package:manger_mission/core/models/auth__model.dart';
import 'package:manger_mission/core/themes/themes.dart';
import 'package:manger_mission/core/validates/validation_mixin.dart';
import 'package:manger_mission/core/widgets/google_button.dart';
import 'package:manger_mission/view/auth/register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

TextEditingController emailController = TextEditingController();

TextEditingController passwordController = TextEditingController();
bool checkedBox = false;
bool obscureText = true;

final formKey = GlobalKey<FormState>();

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      backgroundColor: Constants.colorWhite,
      extendBody: true,
      body: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      bottom: Get.width / 5, top: Get.height / 7),
                  child: _title(context),
                ),
                Column(
                  children: [
                    _emailCardTextfield(),
                    Constants.sizedBoxHeight20,
                    _passwordCardTextfield(),
                    Constants.sizedBoxHeight20,
                    _rowCheckBoxAnfForgetText(context),
                    Constants.sizedBoxHeight20,
                    _loginButton(context),
                    Constants.sizedBoxHeight20,
                    _greyText(context, "Or Login with "),
                    Constants.sizedBoxHeight20,
                    const GoogleButton(),
                    Constants.sizedBoxHeight20,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _greyText(context, "If you don't have an acocount? "),
                        _customTextButton(context, "Sign Up")
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Text _greyText(BuildContext context, String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        color: Constants.colorGrey,
      ),
    );
  }

  Checkbox _checkBox() {
    return Checkbox(
      tristate: true,
      value: checkedBox,
      activeColor: Colors.orange,
      onChanged: (newBool) {
        setState(() {
          checkedBox = !checkedBox;

          log("checkBoxController  :  ${checkedBox}");
        });
      },
    );
  }

  Widget _loginButton(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: Constants.borderRadius15),
        elevation: 5,
        child: CupertinoButton(
          color: Constants.primaryColor,
          borderRadius: Constants.borderRadius15,
          onPressed: () async {
            if (formKey.currentState?.validate() == true) {
              AuthController.instance.login(
                  authModel: AuthModel(
                      email: emailController.text.trim(),
                      password: passwordController.text.trim()));
              emailController.clear();
              passwordController.clear();
            }
          },
          child: Text("Login", style: buttonTextStyleWhite),
        ),
      ),
    );
  }

  Row _rowCheckBoxAnfForgetText(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // Row(
        //   children: [
        //     _checkBox(),
        //     _rememberText(context)
        //   ],
        // ),
        _customTextButton(context, "Forgot to Password ?")
      ],
    );
  }

  Text _title(BuildContext context) {
    return Text(
      "Welcome To Login Page ",
      style: Theme.of(context)
          .textTheme
          .headline5
          ?.copyWith(color: Constants.colorBlack, fontWeight: FontWeight.bold),
    );
  }

  Card _emailCardTextfield() {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: Constants.borderRadius15),
      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Center(
          child: TextFormField(
            validator: Validations().validateEmailName,
            keyboardType: TextInputType.emailAddress,
            controller: emailController,
            decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Please Write to an Email Ex: adasd@dada ",
                prefixIcon: Icon(
                  Icons.email_sharp,
                  size: 25,
                ),
                labelText: "Email"),
          ),
        ),
      ),
    );
  }

  Card _passwordCardTextfield() {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: Constants.borderRadius15),
      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Center(
          child: TextFormField(
            validator: Validations().validatePassword,
            keyboardType: TextInputType.name,
            obscureText: obscureText,
            controller: passwordController,
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Please Write to a Password ",
                prefixIcon: const Icon(
                  Icons.lock_outline,
                  size: 25,
                ),
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      obscureText = !obscureText;
                      log("obscureText in değeri  :  ${obscureText}");
                    });
                  },
                  child: obscureText == true
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

  Text _rememberText(BuildContext context) {
    return Text(
      "Remember Me !",
      style: Theme.of(context)
          .textTheme
          .subtitle1
          ?.copyWith(color: Constants.colorBlack, fontWeight: FontWeight.bold),
    );
  }

  TextButton _customTextButton(BuildContext context, String title) {
    return TextButton(
        onPressed: () {
          title == "Sign Up"
              ? Get.to(
                  () => const RegisterPage(),
                  duration: const Duration(seconds: 1),
                  curve: Curves.bounceOut,
                )
              : _showDialogDesigned();
        },
        child: Text(
          title,
          style: Theme.of(context).textTheme.subtitle1?.copyWith(
              color: Constants.primaryColor, fontWeight: FontWeight.bold),
        ));
  }

  _showDialogDesigned() {
    return Get.dialog(AlertDialog(
      title: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Container(
            width: double.minPositive,
            height: double.minPositive,
            decoration: BoxDecoration(
                borderRadius: Constants.borderRadius40,
                border: Border.all(width: 2, color: Constants.colorGrey)),
            child: const Center(
              child: Icon(
                Icons.close_sharp,
                color: Constants.colorRed,
                size: 40,
              ),
            ),
          )),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _greyText(context, "Bakım Aşamasındadır"),
          Constants.sizedBoxHeight10,
          const CircularProgressIndicator.adaptive(
            backgroundColor: Constants.colorRed,
          ),
        ],
      ),
    ));
  }
}
