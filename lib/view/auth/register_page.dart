// ignore_for_file: deprecated_member_use, prefer_const_constructors

import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manger_mission/core/constants/constants.dart';
import 'package:manger_mission/core/controllers/auth_controller.dart';
import 'package:manger_mission/core/models/auth__model.dart';
import 'package:manger_mission/core/validates/validations.dart';
import 'package:manger_mission/core/widgets/google_button.dart';
import 'package:manger_mission/core/widgets/grey_text.dart';
import 'package:manger_mission/core/widgets/text_title.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

final TextEditingController nameController = TextEditingController();
final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();

bool registerObscureText = true;
final GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.colorWhite,
      appBar: null,
      extendBody: true,
      body: SingleChildScrollView(
        child: Form(
          key: registerFormKey,
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
            child: Column(
              children: [
                _image(),
                TextTitle(title: "Create Account"),
                Constants.sizedBoxHeight10,
                _nameTextField(),
                Constants.sizedBoxHeight15,
                _emailTextfield(),
                Constants.sizedBoxHeight15,
                _passwordTextfield(),
                Constants.sizedBoxHeight20,
                _createButton(context),
                Constants.sizedBoxHeight10,
                const GreyText(title: "Or Sign Up with"),
                Constants.sizedBoxHeight10,
                const GoogleButton(),
                _textsIfSingIn(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _image() {
    return Stack(
      children: [
        Hero(
          tag: "image",
          child: Image.asset(
            "assets/images/login_image.png",
            width: Get.width,
            height: Get.width / 1.5,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: 30,
          child: InkWell(
            onTap: () {
              Get.back();
            },
            child: CircleAvatar(
              backgroundColor: Constants.colorGrey200,
              radius: 22,
              child: const Center(
                child: Icon(
                  Icons.arrow_back_ios_new_outlined,
                  size: 30,
                  color: Constants.colorBlack,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  TextButton _textsIfSingIn(BuildContext context) {
    return TextButton(
        onPressed: () {
          Get.back();
        },
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                  text: "You have an account? ",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(color: Constants.colorGrey, fontSize: 20)),
              TextSpan(
                  text: "  SignIn",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(color: Constants.blusihColor, fontSize: 20)),
            ],
          ),
        ));
  }

  Widget _createButton(BuildContext context) {
    return SizedBox(
      width: Get.width,
      child: CupertinoButton(
        color: Constants.primaryColor,
        onPressed: () async {
          if (registerFormKey.currentState?.validate() == true) {
            AuthController.instance.register(
                authModel: AuthModel(
                    name: nameController.text.trim(),
                    email: emailController.text.trim(),
                    password: passwordController.text.trim()));

            nameController.clear();
            emailController.clear();
            passwordController.clear();
          }
        },
        child: Text(Constants.textCreateAccount,
            style: Theme.of(context).textTheme.subtitle1?.copyWith(
                  color: Constants.colorWhite,
                  fontSize: 20,
                )),
      ),
    );
  }

  Card _nameTextField() {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: Constants.borderRadius10),
      child: TextFormField(
        validator: Validations().validateName,
        keyboardType: TextInputType.name,
        controller: nameController,
        decoration: const InputDecoration(
            contentPadding: Constants.paddingLeft20,
            border: InputBorder.none,
            hintText: "Please Write to a Name Ex: ibrahim ",
            suffixIcon: Icon(
              Icons.person,
              size: 30,
            ),
            labelText: "Name"),
      ),
    );
  }

  Card _emailTextfield() {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: Constants.borderRadius10),
      child: TextFormField(
        validator: Validations().validateEmailName,
        keyboardType: TextInputType.emailAddress,
        controller: emailController,
        decoration: const InputDecoration(
            contentPadding: Constants.paddingLeft20,
            border: InputBorder.none,
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
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: Constants.borderRadius10),
      child: TextFormField(
        validator: Validations().validatePassword,
        keyboardType: TextInputType.name,
        obscureText: registerObscureText,
        controller: passwordController,
        decoration: InputDecoration(
          contentPadding: Constants.paddingLeft20,
          border: InputBorder.none,
          hintText: "Please Write to a Password ",
          labelText: "Password",
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                registerObscureText = !registerObscureText;
                log("obscureText in değeri  :  $registerObscureText");
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
        ),
      ),
    );
  }
}
