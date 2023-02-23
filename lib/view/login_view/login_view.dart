library login_view;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wurigiri/controller/controller.dart';
import 'package:wurigiri/controller/login_controller.dart';
import 'package:wurigiri/controller/user_controller.dart';
import 'package:wurigiri/model/user.dart';
import 'package:wurigiri/view/login_view/connect_view/connect_view.dart';
import 'package:wurigiri/widget/text_field.dart';

part './login_view_model.dart';

class Loginview extends StatelessWidget {
  Loginview({super.key});

  final LoginViewModel viewModel = LoginViewModel();

  AppBar appBar() {
    return AppBar(
      title: const Text("LoginView"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Center(
        child: SizedBox(
          width: Get.width * 0.7,
          child: GetBuilder<LoginController>(builder: (controller) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                WTextField(
                  controller: viewModel.idController,
                  hintText: "닉네임을 입력해주세요",
                ),
                ElevatedButton(
                  onPressed: () async {
                    FocusManager.instance.primaryFocus?.unfocus();
                    await viewModel.onTapNext();
                    Get.to(ConnectView());
                  },
                  child: const Text("ok"),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
