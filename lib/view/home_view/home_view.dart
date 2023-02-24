library home_view;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wurigiri/controller/calendar_controller.dart';
import 'package:wurigiri/controller/chat_controller.dart';
import 'package:wurigiri/controller/controller.dart';
import 'package:wurigiri/controller/feed_controller.dart';
import 'package:wurigiri/controller/file_controller.dart';
import 'package:wurigiri/controller/notify_controller.dart';
import 'package:wurigiri/controller/public_controller.dart';
import 'package:wurigiri/controller/user_controller.dart';
import 'package:wurigiri/model/public/public.dart';
import 'package:wurigiri/model/user.dart';
import 'package:wurigiri/repo/calendar/calendar_repo.dart';
import 'package:wurigiri/repo/chat/chat_repo.dart';
import 'package:wurigiri/repo/feed/feed_repo.dart';
import 'package:wurigiri/repo/file/file_repo.dart';
import 'package:wurigiri/repo/notify/notify_repo.dart';
import 'package:wurigiri/repo/public/public_repo.dart';
import 'package:wurigiri/view/calendar_view/calendar_view.dart';
import 'package:wurigiri/view/chat_view/chat_view.dart';
import 'package:wurigiri/view/feed_view/feed_view.dart';
import 'package:wurigiri/view/home_view/user_data_view/user_data_view.dart';
import 'package:wurigiri/view/setting_view/setting_view.dart';
import 'package:wurigiri/widget/background.dart';
import 'package:wurigiri/widget/bottom_sheet.dart';
import 'package:wurigiri/widget/glass_box.dart';
import 'package:wurigiri/widget/image_picker.dart';
import 'package:wurigiri/widget/loading.dart';
part './home_view_model.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

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
      child: UserDataView(),
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
                Get.to(const CalendarView());
              },
              icon: const Icon(Icons.calendar_month),
            ),
            const SizedBox(width: 8.0),
            IconButton(
              onPressed: () {
                Get.to(const ChatView());
              },
              icon: const Icon(Icons.chat),
            ),
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
            final actionList = [
              WBottomSheetButton(
                text: "Select Photo",
                onTap: () {
                  viewModel.updateHomePhoto();
                  Get.back();
                },
              ),
            ];
            if (viewModel.mainPhotoURL.isNotEmpty) {
              actionList.add(
                WBottomSheetButton(
                  text: "Remove Photo",
                  isRed: true,
                  onTap: () {
                    viewModel.removeHomePhoto();
                    Get.back();
                  },
                ),
              );
            }
            WBottomSheet(
              actions: actionList,
              cancelButton: WBottomSheetButton.cancel(
                onTap: () {
                  Get.back();
                },
              ),
            ).show(context);
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

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(
      builder: (controller) {
        if (viewModel.isLoading) {
          return const WLoading();
        }
        final mainPhotoURL = viewModel.mainPhotoURL;
        return WBackground(
          backgroundURL: mainPhotoURL,
          child: Scaffold(
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
        );
      },
    );
  }
}
