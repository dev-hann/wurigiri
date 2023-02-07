import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wurigiri/consts/const.dart';
import 'package:wurigiri/controller/chat_controller.dart';
import 'package:wurigiri/controller/controller.dart';
import 'package:wurigiri/controller/feed_controller.dart';
import 'package:wurigiri/controller/notify_controller.dart';
import 'package:wurigiri/controller/public_controller.dart';
import 'package:wurigiri/controller/user_controller.dart';
import 'package:wurigiri/repo/chat/chat_repo.dart';
import 'package:wurigiri/repo/feed/feed_repo.dart';
import 'package:wurigiri/repo/notify/notify_repo.dart';
import 'package:wurigiri/repo/public/public_repo.dart';
import 'package:wurigiri/view/chat_view/chat_view.dart';
import 'package:wurigiri/view/feed_view/feed_view.dart';

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
    super.initState();
    final userController = UserController.find();
    final publicID = userController.publicID;
    Controller.put(ChatController(ChatImpl(publicID)));
    Get.put(PublicController(PublicImpl(publicID)));
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
    return Text("$inDays");
  }

  Widget icons() {
    return GetBuilder<NotifyController>(
      builder: (controller) {
        final notify = controller.notify;
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Badge(
              isLabelVisible: notify.feed,
              child: GestureDetector(
                onTap: () {
                  Get.to(const FeedView());
                },
                child: const Icon(Icons.history),
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.to(ChatView());
              },
              child: Badge.count(
                count: notify.chat,
                child: const Icon(Icons.chat),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: const Icon(Icons.settings),
            ),
          ],
        );
      },
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
          SizedBox(height: 16.0),
          icons(),
          SizedBox(height: 16.0),
        ],
      ),
    );
  }
}
