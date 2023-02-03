import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:wurigiri/controller/controller.dart';
import 'package:wurigiri/controller/login_controller.dart';
import 'package:wurigiri/controller/user_controller.dart';

import 'package:wurigiri/repo/login/login_repo.dart';
import 'package:wurigiri/repo/user/user_repo.dart';
import 'package:wurigiri/view/home_view.dart';
import 'package:wurigiri/view/login_view/login_view.dart';
import 'package:wurigiri/widget/w_loading.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Firebase.initializeApp();
  await Controller.put<UserController>(UserController(UserImpl()));
  Get.put(LoginController(LoginImpl()));
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
    }
    Get.off(user == null ? Loginview() : const HomeView());
  }

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: WLoading(),
      ),
    );
  }
}
