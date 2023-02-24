library user_data_view;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wurigiri/controller/public_controller.dart';
import 'package:wurigiri/controller/user_controller.dart';
import 'package:wurigiri/model/public/public.dart';
import 'package:wurigiri/model/user.dart';
import 'package:wurigiri/util/time_format.dart';
import 'package:wurigiri/view/user_detail_view/user_detail_view.dart';
import 'package:wurigiri/widget/head_photo.dart';
part './user_data_view_model.dart';

class UserDataView extends StatelessWidget {
  UserDataView({super.key});
  final UserDataViewModel viewModel = UserDataViewModel();

  Widget dDayText() {
    return GetBuilder<PublicController>(
      builder: (controller) {
        final setting = viewModel.homeSetting;
        final firstMeet = viewModel.firstMeet;
        final inDays = WTimeFormat(firstMeet).calculateDay().abs();

        return Column(
          children: [
            setting.showFristMeetDateTime
                ? Text(WTimeFormat(firstMeet).dateFormat)
                : const SizedBox(),
            setting.showDDay ? Text("$inDays일째") : const SizedBox(),
            const Icon(
              Icons.favorite,
              color: Colors.red,
            ),
          ],
        );
      },
    );
  }

  Widget userWidget(User user) {
    return GestureDetector(
      onTap: () {
        Get.to(UserDetailView(user: user));
      },
      child: GetBuilder<UserController>(
        builder: (controller) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              WHeadPhoto(
                user.headPhoto,
                size: 56.0,
              ),
              Text(user.name),
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        userWidget(viewModel.other),
        dDayText(),
        userWidget(viewModel.user),
      ],
    );
  }
}
