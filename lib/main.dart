import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_x_tutorial/constants.dart';
import 'package:get_x_tutorial/controller/auth_controller.dart';
import 'package:get_x_tutorial/view/screens/auth/signup_screen.dart';

import 'firebase_options.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((value){
    Get.put(AuthController());
  });
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'TikTok',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: backgroundColor
      ),
      home: SignUpScreen(),
    );
  }
}
