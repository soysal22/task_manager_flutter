// ignore_for_file: avoid_print, unrelated_type_equality_checks, unused_element, unnecessary_brace_in_string_interps, non_constant_identifier_names, deprecated_member_use, prefer_const_constructors

import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manger_mission/core/constants/constants.dart';
import 'package:manger_mission/core/controllers/auth_controller.dart';
import 'package:manger_mission/core/models/auth__model.dart';
import 'package:manger_mission/core/themes/themes.dart';
import 'package:manger_mission/core/validates/validations.dart';
import 'package:manger_mission/core/widgets/google_button.dart';
import 'package:manger_mission/core/widgets/grey_text.dart';
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

final GlobalKey<ScaffoldState> scaffoldKeyO = GlobalKey<ScaffoldState>();

final loginFormKey = GlobalKey<FormState>();

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKeyO,
      appBar: null,
      backgroundColor: Constants.colorWhite,
      extendBody: true,
      body: Form(
        key: loginFormKey,
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.only(left: 8, right: 8, top: 20, bottom: 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _image(),
                _title(context),
                Constants.sizedBoxHeight10,
                _emailCardTextfield(),
                Constants.sizedBoxHeight10,
                _passwordCardTextfield(),
                _forgoTextButton(context),
                _loginButton(context),
                Constants.sizedBoxHeight10,
                const GreyText(title: "Or Login with"),
                Constants.sizedBoxHeight10,
                const GoogleButton(),
                Constants.sizedBoxHeight15,
                _textsIfSingUp(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Hero _image() {
    return Hero(
      tag: "image",
      child: Image.asset(
        Constants.imageLogin,
        fit: BoxFit.cover,
        height: Get.width / 1.5,
      ),
    );
  }

  TextButton _textsIfSingUp(BuildContext context) {
    return TextButton(
        onPressed: () {
          Get.to(() => const RegisterPage());
        },
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                  text: "If you don't have an acocount? ",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(color: Constants.colorGrey, fontSize: 19)),
              TextSpan(
                  text: "SignUp",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(color: Constants.blusihColor, fontSize: 20)),
            ],
          ),
        ));
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
            if (loginFormKey.currentState?.validate() == true) {
              AuthController.instance.login(
                  authModel: AuthModel(
                      email: emailController.text.trim(),
                      password: passwordController.text.trim()));
            }
          },
          child: Text("Login", style: buttonTextStyleWhite),
        ),
      ),
    );
  }

  Widget _forgoTextButton(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
          onPressed: () {
            _showDialogDesigned();
          },
          child: Text(
            "Forgot to Password ?",
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: Constants.blusihColor, fontSize: 16),
          )),
    );
  }

  _showDialogDesigned() {
    return Get.dialog(
        barrierDismissible: true,
        barrierColor: Constants.colorGrey400,
        AlertDialog(
          title: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  GreyText(title: "Bakım Aşamasındadır"),
                  Constants.sizedBoxHeight10,
                  CircularProgressIndicator.adaptive(
                    backgroundColor: Constants.colorRed,
                  ),
                ],
              ),
              Positioned(
                  right: 5,
                  child: CircleAvatar(
                    backgroundColor: Constants.colorWhite,
                    radius: 25,
                    child: Icon(
                      Icons.close,
                      color: Constants.colorRed,
                      size: 30,
                    ),
                  ))
            ],
          ),
        ));
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
}
