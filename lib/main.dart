import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:wurigiri/controller/controller.dart';
import 'package:wurigiri/controller/login_controller.dart';
import 'package:wurigiri/controller/user_controller.dart';

import 'package:wurigiri/repo/login/login_repo.dart';
import 'package:wurigiri/repo/user/user_repo.dart';
import 'package:wurigiri/view/home_view/home_view.dart';
import 'package:wurigiri/view/login_view/login_view.dart';
import 'package:wurigiri/widget/loading.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Firebase.initializeApp();
  await Controller.put(UserController(UserImpl()));
  await Controller.put(LoginController(LoginImpl()));
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final userController = UserController.find();
  final loginController = LoginController.find();

  @override
  void initState() {
    super.initState();
    login();
  }

  Future login() async {
    final deviceID = await loginController.loadDeviceID();
    final user = await userController.requestUser(deviceID);
    if (user != null) {
      await userController.updateUser(user);
      await userController.reqeustOther();
    }
    Get.off(user == null ? Loginview() : const HomeView());
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          color: Colors.transparent,
          elevation: 0.0,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
        cardTheme: CardTheme(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const Scaffold(
        body: WLoading(),
      ),
    );
  }
}
