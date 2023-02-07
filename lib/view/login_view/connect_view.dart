import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wurigiri/controller/login_controller.dart';
import 'package:wurigiri/controller/user_controller.dart';
import 'package:wurigiri/model/connection.dart';
import 'package:wurigiri/view/home_view.dart';
import 'package:wurigiri/widget/w_loading.dart';

class ConnectView extends StatelessWidget {
  ConnectView({
    super.key,
  });

  final userController = UserController.find();
  final loginController = LoginController.find();
  final codeController = TextEditingController();

  AppBar appBar() {
    return AppBar(
      title: const Text("IntroView"),
    );
  }

  Widget inviteAlert() {
    return Center(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FutureBuilder<String>(
            future: loginController.invite(),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const WLoading();
              }
              final inviteCode = snapshot.data!;
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(inviteCode),
                  const WLoading(),
                  ElevatedButton(
                    onPressed: () {
                      loginController.cancelInvite(inviteCode);
                      Get.back();
                    },
                    child: const Text("cancel"),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: GetBuilder<LoginController>(
        builder: (controller) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: codeController,
              ),
              ElevatedButton(
                onPressed: () async {
                  final inviteCode = codeController.text;
                  final connection = await loginController.connect(inviteCode);
                  if (connection == null) {
                    return;
                  }
                  final newUser = userController.user.copyWith(
                    publicID: inviteCode,
                    otherID: connection.invitator,
                  );
                  await userController.updateUser(
                    newUser,
                    withServer: true,
                  );
                  Get.to(const HomeView());
                },
                child: const Text("Connect"),
              ),
              ElevatedButton(
                onPressed: () async {
                  final res = await Get.dialog(
                    inviteAlert(),
                    barrierDismissible: false,
                  );
                  if (res != null) {
                    final connection = res as Connection;
                    final newUser = userController.user.copyWith(
                      publicID: connection.publicID,
                      otherID: connection.guest,
                    );
                    await userController.updateUser(
                      newUser,
                      withServer: true,
                    );
                    await loginController.connected(connection.publicID);
                    Get.to(const HomeView());
                  }
                },
                child: const Text("Invite"),
              ),
            ],
          );
        },
      ),
    );
  }
}
