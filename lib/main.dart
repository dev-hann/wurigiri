import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wurigiri/controller/chat_controller.dart';
import 'package:wurigiri/controller/feed_controller.dart';
import 'package:wurigiri/controller/notify_controller.dart';
import 'package:wurigiri/controller/setting_controller.dart';
import 'package:wurigiri/controller/user_controller.dart';
import 'package:wurigiri/repo/chat/chat_repo.dart';
import 'package:wurigiri/repo/feed/feed_repo.dart';
import 'package:wurigiri/repo/notify/notify_repo.dart';
import 'package:wurigiri/repo/setting/setting_repo.dart';
import 'package:wurigiri/repo/user/user_repo.dart';
import 'package:wurigiri/view/home_view.dart';
import 'package:wurigiri/view/login_view/login_view.dart';
import 'package:wurigiri/widget/w_loading.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(UserController(UserImpl()));
  Get.put(SettingController(SettingImpl()));
  Get.put(NotifyController(NotifyImpl()));
  Get.put(FeedController(FeedImpl()));
  Get.put(ChatController(ChatImpl()));
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
    final isNotEmpty = userController.loadUser();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Get.off(isNotEmpty ? const HomeView() : Loginview());
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
