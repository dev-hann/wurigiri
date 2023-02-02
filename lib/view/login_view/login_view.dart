import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wurigiri/controller/login_controller.dart';
import 'package:wurigiri/model/user.dart';
import 'package:wurigiri/repo/login/login_repo.dart';
import 'package:wurigiri/view/login_view/connect_view.dart';

class Loginview extends StatelessWidget {
  Loginview({super.key});
  final loginController = Get.put(LoginController(LoginImpl()));

  final idController = TextEditingController();

  AppBar appBar() {
    return AppBar(
      title: const Text("LoginView"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: idController,
          ),
          ElevatedButton(
            onPressed: () async {
              final newUser = User(
                id: await loginController.loadDeviceID(),
                headPhoto: '',
                name: idController.text,
              );
              Get.to(
                ConnectView(tmpUser: newUser),
              );
            },
            child: const Text("ok"),
          ),
        ],
      ),
    );
  }
}
