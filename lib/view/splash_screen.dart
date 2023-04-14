import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:manger_mission/view/auth/login_page.dart';
import 'package:manger_mission/view/deneme/deneme_obx_home.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: null,
        body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const DenemeHome();
            } else {
              return const LoginPage();
            }
          },
        ));
  }
}

/*  // @override
  void initState() {
    super.initState();
    firebaseInit();
  }

  Future firebaseInit() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    setState(() {
      FirebaseAuth.instance.userChanges().listen((User? user) {
        if (user == null) {
          Get.to(() => const LoginPage());
        } else {
          Get.to(() => const DenemeHome());
        }
      });
      // if (FirebaseAuth.instance.currentUser != null) {
      //   log(" ${FirebaseAuth.instance.currentUser?.displayName ?? "User Name"} Kullanıcısı Giriş Yaptı");
      //   Get.to(() => const DenemeHome());
      // } else {
      //   Get.to(() => const LoginPage());
      // }
    });
  }
 */