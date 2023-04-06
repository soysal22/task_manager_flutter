import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manger_mission/view/auth/login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // firebaseInit();
    git();
    super.initState();
  }

  Future<void> git() async {
    Future.delayed(
        const Duration(seconds: 1), () => Get.to(() => const LoginPage()));
  }

  // Future<void> firebaseInit() async {
  //   WidgetsFlutterBinding.ensureInitialized();
  //   await Firebase.initializeApp();
  //   setState(() {
  //     if (FirebaseAuth.instance.currentUser != null) {
  //       log(" ${FirebaseAuth.instance.currentUser!.displayName} Kullanıcısı Giriş Yaptı");
  //       Get.offAll(() => const DenemeHome());
  //     } else {
  //       Get.offAll(() => const LoginPage());
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        appBar: null,
        body: Center(
          child: CircularProgressIndicator(),
        ));
  }
}
