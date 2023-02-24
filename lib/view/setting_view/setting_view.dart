import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wurigiri/controller/public_controller.dart';
import 'package:wurigiri/controller/user_controller.dart';
import 'package:wurigiri/util/time_format.dart';
import 'package:wurigiri/view/setting_view/setting_view_model.dart';
import 'package:wurigiri/view/user_detail_view/user_detail_view.dart';
import 'package:wurigiri/widget/date_picker.dart';
import 'package:wurigiri/widget/head_photo.dart';
import 'package:wurigiri/widget/list_tile.dart';
import 'package:wurigiri/widget/switch.dart';

class SettingView extends StatelessWidget {
  SettingView({super.key});
  final SettingViewModel viewModel = SettingViewModel();
  AppBar appBar() {
    return AppBar(
      title: const Text("설정"),
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

  Widget settingCard({
    required String title,
    required List<Widget> itemList,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(title),
        const SizedBox(height: 8.0),
        Card(
          child: Column(
            children: itemList,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: GetBuilder<PublicController>(
          builder: (controller) {
            final public = viewModel.public;
            final setting = public.homeSetting;
            return Column(
              children: [
                headPhoto(),
                const SizedBox(height: 16.0),
                settingCard(
                  title: "Title",
                  itemList: [
                    WListTile(
                      onTap: () async {
                        final res = await WDatePicker.picker(
                          context,
                          currentTime: public.firstMeet,
                        );
                        if (res == null) {
                          return;
                        }
                        viewModel.updateFirstMeet(res);
                      },
                      title: const Text("처음 만난 날"),
                      trailing: Text(WTimeFormat(public.firstMeet).dateFormat),
                    ),
                    WListTile(
                      onTap: () {},
                      title: const Text("날짜보기"),
                      trailing: WSwitch(
                        value: setting.showFristMeetDateTime,
                        onChanged: (value) {
                          viewModel.updateHomeSetting(
                            setting.copyWith(
                              showFristMeetDateTime: value,
                            ),
                          );
                        },
                      ),
                    ),
                    WListTile(
                      onTap: () {},
                      title: const Text("디데이보기"),
                      trailing: WSwitch(
                        value: setting.showDDay,
                        onChanged: (value) {
                          viewModel.updateHomeSetting(
                            setting.copyWith(
                              showDDay: value,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
