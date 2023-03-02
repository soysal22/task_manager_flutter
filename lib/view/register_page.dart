import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manger_mission/core/constants/constants.dart';
import 'package:manger_mission/core/validates/validation_mixin.dart';
import 'package:manger_mission/view/login_dene.dart';

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
        backgroundColor: Constants.colorWhite,
        appBar: _appBarDesign(),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Form(
            key: registerFormKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _nameTextField(),
                  Constants.sizedBoxHeight20,
                  _emailTextfield(),
                  Constants.sizedBoxHeight20,
                  _passwordTextfield(),
                  Constants.sizedBoxHeight20,
                  _createButton(context),
                  Constants.sizedBoxHeight20,
                  _greyText(context, "Or Sign Up with"),
                  Constants.sizedBoxHeight20,
                  _googleButton(context),
                  Constants.sizedBoxHeight20,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _greyText(context, "You have an account? "),
                      _siginButton(context)
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

// google giriş kısımlarıını ekle
  Widget _googleButton(BuildContext context) {
    return SizedBox(
      width: Get.width,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: Constants.borderRadius15),
        elevation: 5,
        child: CupertinoButton(
          color: Constants.colorWhite,
          borderRadius: Constants.borderRadius15,
          onPressed: () async {
            Get.to(
              duration: const Duration(seconds: 1),
              curve: Curves.bounceOut,
              () {},
            );
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.g_mobiledata,
                size: 35,
                color: Constants.primaryColor,
              ),
              _buttonText(context, "Google", Constants.colorBlack),
            ],
          ),
        ),
      ),
    );
  }

  TextButton _siginButton(BuildContext context) {
    return TextButton(
        onPressed: () {
          Get.back();
        },
        child: Text(
          "Sign In",
          style: Theme.of(context).textTheme.subtitle1?.copyWith(
              color: Constants.primaryColor, fontWeight: FontWeight.bold),
        ));
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

  Widget _createButton(BuildContext context) {
    return SizedBox(
      width: Get.width,
      child: CupertinoButton(
        color: Constants.primaryColor,
        onPressed: () async {
          if (registerFormKey.currentState?.validate() == true) {
            Get.to(
              duration: const Duration(seconds: 1),
              curve: Curves.bounceOut,
              const LoginPage(),
            );
          }
        },
        child: _buttonText(
            context, Constants.textCreateAccount, Constants.colorWhite),
      ),
    );
  }

  Text _buttonText(BuildContext context, String title, Color color) {
    return Text(title,
        style: Theme.of(context).textTheme.subtitle1?.copyWith(
              color: color,
              fontSize: 20,
            ));
  }

  Card _nameTextField() {
    return Card(
      child: TextFormField(
        validator: Validations().validateName,
        keyboardType: TextInputType.name,
        controller: registerNameController,
        decoration: const InputDecoration(
            contentPadding: Constants.paddingLeft20,
            border: InputBorder.none,
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
        validator: Validations().validateEmailName,
        keyboardType: TextInputType.emailAddress,
        controller: registerEmailController,
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
      child: TextFormField(
        validator: Validations().validatePassword,
        keyboardType: TextInputType.name,
        obscureText: registerObscureText,
        controller: registerPasswordController,
        decoration: InputDecoration(
            contentPadding: Constants.paddingLeft20,
            border: InputBorder.none,
            hintText: "Please Write to a Password ",
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
            labelText: "Passsword "),
      ),
    );
  }

  AppBar _appBarDesign() {
    return AppBar(
      backgroundColor: Constants.colorWhite,
      elevation: 0,
      automaticallyImplyLeading: false,
      leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: Constants.colorBlack,
          )),
      centerTitle: true,
      title: const Text(
        Constants.textCreateAccount,
        style: TextStyle(color: Constants.colorBlack),
      ),
    );
  }
}
