import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wurigiri/consts/const.dart';
import 'package:wurigiri/controller/chat_controller.dart';
import 'package:wurigiri/controller/controller.dart';
import 'package:wurigiri/controller/feed_controller.dart';
import 'package:wurigiri/controller/notify_controller.dart';
import 'package:wurigiri/controller/public_controller.dart';
import 'package:wurigiri/controller/file_controller.dart';
import 'package:wurigiri/controller/user_controller.dart';
import 'package:wurigiri/repo/chat/chat_repo.dart';
import 'package:wurigiri/repo/feed/feed_repo.dart';
import 'package:wurigiri/repo/notify/notify_repo.dart';
import 'package:wurigiri/repo/public/public_repo.dart';
import 'package:wurigiri/repo/file/file_repo.dart';
import 'package:wurigiri/view/chat_view/chat_view.dart';
import 'package:wurigiri/view/feed_view/feed_view.dart';
import 'package:wurigiri/view/setting_view/setting_view.dart';
import 'package:wurigiri/view/user_detail_view/user_detail_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  static MaterialPageRoute<void> route() {
    return MaterialPageRoute(
      builder: (context) {
        return const HomeView();
      },
    );
  }

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final userController = UserController.find();
  @override
  void initState() {
    super.initState();
    final publicID = userController.publicID;
    userController.reqeustOther();
    Controller.put<ChatController>(ChatController(ChatImpl(publicID)));
    Controller.put<FileController>(FileController(FileImpl()));
    Controller.put<PublicController>(PublicController(PublicImpl(publicID)));
    Get.put(FeedController(FeedImpl(publicID)));
    Get.put(NotifyController(NotifyImpl()));
  }

  AppBar appBar() {
    return AppBar(
      title: const Text("title"),
    );
  }

  Widget dDayText() {
    final inDays = DateTime.now().difference(firstMeet).inDays;
    return GestureDetector(
      onTap: () {
        Get.to(
          UserDetailView(user: userController.user),
        );
      },
      child: Text("$inDays"),
    );
  }

  Widget icons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        GestureDetector(
          onTap: () {
            Get.to(const FeedView());
          },
          child: const Icon(Icons.history),
        ),
        GestureDetector(
          onTap: () {
            Get.to(const ChatView());
          },
          child: const Icon(Icons.chat),
        ),
        GestureDetector(
          onTap: () {
            Get.to(const SettingView());
          },
          child: const Icon(Icons.settings),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          dDayText(),
          const SizedBox(height: 16.0),
          icons(),
          const SizedBox(height: 16.0),
        ],
      ),
    );
  }
}
