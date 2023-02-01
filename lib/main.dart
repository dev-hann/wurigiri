import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wurigiri/controller/notify_controller.dart';
import 'package:wurigiri/controller/setting_controller.dart';
import 'package:wurigiri/controller/user_controller.dart';
import 'package:wurigiri/repo/fire/fire_repo.dart';
import 'package:wurigiri/repo/notify/notify_repo.dart';
import 'package:wurigiri/repo/user/user_repo.dart';
import 'package:wurigiri/view/home_view.dart';
import 'package:wurigiri/view/intro_view/intro_view.dart';
import 'package:wurigiri/widget/w_loading.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final userRepo = UserImpl();
  final fireRepo = FireImpl();
  final settingRepo = NotifyImpl();
  Get.put(UserController(userRepo, fireRepo));
  Get.lazyPut(() => SettingController(settingRepo, fireRepo));
  Get.lazyPut(() => NotifyController(settingRepo));
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final userController = UserController.find();

  @override
  void initState() {
    super.initState();
    userController.requestUser().then((user) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Get.off(user == null ? const IntroView() : const HomeView());
      });
    });
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
