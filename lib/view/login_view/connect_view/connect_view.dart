library connect_view;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wurigiri/controller/controller.dart';
import 'package:wurigiri/controller/login_controller.dart';
import 'package:wurigiri/controller/user_controller.dart';
import 'package:wurigiri/model/connection.dart';
import 'package:wurigiri/view/home_view/home_view.dart';
import 'package:wurigiri/widget/loading.dart';
import 'package:wurigiri/widget/text_field.dart';
part './connect_view_model.dart';

class ConnectView extends StatelessWidget {
  ConnectView({
    super.key,
  });

  final ConnectViewModel viewModel = ConnectViewModel();

  AppBar appBar() {
    return AppBar(
      title: const Text("IntroView"),
    );
  }

  Widget inviteAlert() {
    final inviteCode = viewModel.inviteCode;
    return Center(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("초대코드 : $inviteCode"),
              const WLoading(),
              ElevatedButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text("취소"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Center(
        child: SizedBox(
          width: Get.width * 0.7,
          child: GetBuilder<LoginController>(
            builder: (controller) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  WTextField(
                    controller: viewModel.codeController,
                    hintText: "상대방의 초대코드를 입력해주세요",
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      FocusManager.instance.primaryFocus?.unfocus();
                      final isOK = await viewModel.connect();
                      if (!isOK) {}
                      if (isOK) {
                        Get.offAll(const HomeView());
                      }
                    },
                    child: const Text("연결하기"),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await viewModel.initInvite(
                        onConnection: (connection) {
                          if (connection.guest.isNotEmpty &&
                              connection.invitator.isNotEmpty) {
                            if (Get.isDialogOpen ?? false) {
                              Get.back(result: connection);
                            }
                          }
                        },
                      );
                      final res = await Get.dialog(
                        inviteAlert(),
                        barrierDismissible: false,
                      );
                      viewModel.disposeInvite();
                      if (res != null) {
                        final connection = res as Connection;
                        await viewModel.connect(
                          inviteCode: connection.publicID,
                          guestID: connection.guest,
                        );
                        Get.offAll(const HomeView());
                      }
                    },
                    child: const Text("초대하기"),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
