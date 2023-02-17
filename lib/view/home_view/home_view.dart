library home_view;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wurigiri/controller/public_controller.dart';
import 'package:wurigiri/controller/user_controller.dart';
import 'package:wurigiri/view/chat_view/chat_view.dart';
import 'package:wurigiri/view/feed_view/feed_view.dart';
import 'package:wurigiri/view/home_view/home_view_model.dart';
import 'package:wurigiri/view/home_view/user_data_view.dart';
import 'package:wurigiri/view/setting_view/setting_view.dart';
import 'package:wurigiri/view/user_detail_view/user_detail_view.dart';
import 'package:wurigiri/widget/background.dart';
import 'package:wurigiri/widget/glass_box.dart';

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
  final HomeViewModel viewModel = HomeViewModel();
  @override
  void initState() {
    super.initState();
    viewModel.init();
  }

  Widget userDataWidget() {
    return WGlassBox(
      child: GetBuilder<UserController>(
        builder: (controller) {
          return UserDataView(
            me: controller.user,
            other: controller.other,
            onTapUser: (user) {
              Get.to(UserDetailView(user: user));
            },
          );
        },
      ),
    );
  }

  Widget icons() {
    return Align(
      alignment: Alignment.bottomRight,
      child: WGlassBox(
        child: Row(
          mainAxisSize: MainAxisSize.min,
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
          ],
        ),
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      actions: [
        IconButton(
          onPressed: () {
            viewModel.updateBackgroundPhoto();
          },
          icon: const Icon(
            Icons.photo,
            color: Colors.white,
          ),
        ),
        IconButton(
          onPressed: () {
            Get.to(SettingView());
          },
          icon: const Icon(
            Icons.settings,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget backgroundImg(String url) {
    if (url.isEmpty) {
      return const SizedBox();
    }
    return ShaderMask(
      blendMode: BlendMode.srcATop,
      shaderCallback: (Rect bounds) {
        return LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black.withOpacity(0.4),
            Colors.transparent,
            Colors.black.withOpacity(0.6),
          ],
        ).createShader(bounds);
      },
      child: Image.network(
        url,
        fit: BoxFit.cover,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PublicController>(
      builder: (controller) {
        return WBackground(
          child: Stack(
            fit: StackFit.expand,
            children: [
              backgroundImg(controller.public.mainPhoto),
              Scaffold(
                appBar: appBar(),
                backgroundColor: Colors.transparent,
                body: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(),
                      // userDataWidget(),
                      icons(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
