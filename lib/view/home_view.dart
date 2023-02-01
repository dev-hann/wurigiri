import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wurigiri/consts/const.dart';
import 'package:wurigiri/controller/notify_controller.dart';
import 'package:wurigiri/controller/setting_controller.dart';
import 'package:wurigiri/view/feed_view/feed_view.dart';
import 'package:wurigiri/widget/w_loading.dart';

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
              label: Text("${notify.feed}"),
              child: GestureDetector(
                onTap: () {
                  Get.to(const FeedView());
                },
                child: const Icon(Icons.history),
              ),
            ),
            GestureDetector(
              onTap: () {
                controller.updateNotofy(
                  notify.copyWith(
                    chat: notify.chat + 1,
                  ),
                );
              },
              child: Badge(
                label: Text("${notify.feed}"),
                child: const Icon(Icons.chat),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Icon(Icons.settings),
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
        children: [
          dDayText(),
          icons(),
          GetBuilder<SettingController>(
            builder: (controller) {
              if (controller.isLoading) {
                return const WLoading();
              }
              return Text(controller.setting!.toMap().toString());
            },
          ),
        ],
      ),
    );
  }
}
