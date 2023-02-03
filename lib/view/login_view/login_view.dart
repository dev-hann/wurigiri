import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wurigiri/controller/login_controller.dart';
import 'package:wurigiri/controller/user_controller.dart';
import 'package:wurigiri/model/user.dart';
import 'package:wurigiri/view/login_view/connect_view.dart';

class Loginview extends StatelessWidget {
  Loginview({super.key});
  final loginController = LoginController.find();
  final userController = UserController.find();
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
              await userController.updateUser(newUser, withServer: true);
              Get.to(ConnectView());
            },
            child: const Text("ok"),
          ),
        ],
      ),
    );
  }
}
