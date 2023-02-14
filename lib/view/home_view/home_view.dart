library home_view;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wurigiri/controller/chat_controller.dart';
import 'package:wurigiri/controller/feed_controller.dart';
import 'package:wurigiri/controller/file_controller.dart';
import 'package:wurigiri/controller/notify_controller.dart';
import 'package:wurigiri/controller/public_controller.dart';
import 'package:wurigiri/controller/user_controller.dart';
import 'package:wurigiri/repo/chat/chat_repo.dart';
import 'package:wurigiri/repo/feed/feed_repo.dart';
import 'package:wurigiri/repo/file/file_repo.dart';
import 'package:wurigiri/repo/notify/notify_repo.dart';
import 'package:wurigiri/repo/public/public_repo.dart';
import 'package:wurigiri/view/chat_view/chat_view.dart';
import 'package:wurigiri/view/feed_view/feed_view.dart';
import 'package:wurigiri/view/home_view/user_data_view.dart';
import 'package:wurigiri/view/setting_view/setting_view.dart';
import 'package:wurigiri/view/user_detail_view/user_detail_view.dart';

part './home_background_view.dart';

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
  @override
  void initState() {
    final userController = UserController.find();
    final publicID = userController.publicID;
    userController.reqeustOther();
    Get.put(ChatController(ChatImpl(publicID))).init();
    Get.put(PublicController(PublicImpl(publicID))).init();
    Get.put(FileController(FileImpl())).init();
    Get.put(FeedController(FeedImpl(publicID))).init();
    Get.put(NotifyController(NotifyImpl()));
    super.initState();
  }

  Widget userDataWidget() {
    return GetBuilder<UserController>(
      id: UserController.userViewID,
      builder: (controller) {
        return UserDataView(
          me: controller.user,
          other: controller.other,
          onTapUser: (user) {
            Get.to(UserDetailView(user: user));
          },
        );
      },
    );
  }

  Widget icons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          onPressed: () {
            Get.to(const FeedView());
          },
          icon: const Icon(Icons.history),
        ),
        const SizedBox(width: 8.0),
        IconButton(
          onPressed: () {
            Get.to(const ChatView());
          },
          icon: const Icon(Icons.chat),
        ),
        const SizedBox(width: 8.0),
        IconButton(
          onPressed: () {
            Get.to(const SettingView());
          },
          icon: const Icon(Icons.settings),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return _HomeBackgroundView(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: kToolbarHeight,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              userDataWidget(),
              icons(),
            ],
          ),
        ),
      ),
    );
  }
}
