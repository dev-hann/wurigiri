import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wurigiri/controller/user_controller.dart';
import 'package:wurigiri/view/setting_view/setting_view_model.dart';
import 'package:wurigiri/view/user_detail_view/user_detail_view.dart';
import 'package:wurigiri/widget/head_photo.dart';

class SettingView extends StatelessWidget {
  SettingView({super.key});
  final SettingViewModel viewModel = SettingViewModel();
  AppBar appBar() {
    return AppBar(
      title: const Text("Setting View"),
    );
  }

  Widget headPhoto() {
    return GetBuilder<UserController>(
      builder: (controller) {
        final user = controller.user;
        return GestureDetector(
          onTap: () {
            Get.to(UserDetailView(user: user));
          },
          child: Column(
            children: [
              WHeadPhoto(
                user.headPhoto,
              ),
              const SizedBox(height: 8.0),
              Text(user.name),
            ],
          ),
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
          headPhoto(),
        ],
      ),
    );
  }
}
