import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wurigiri/controller/login_controller.dart';
import 'package:wurigiri/model/user.dart';
import 'package:wurigiri/widget/w_loading.dart';

class ConnectView extends StatefulWidget {
  const ConnectView({
    super.key,
    required this.tmpUser,
  });

  final User tmpUser;

  @override
  State<ConnectView> createState() => _ConnectViewState();
}

class _ConnectViewState extends State<ConnectView> {
  final loginController = LoginController.find();
  final otherIDController = TextEditingController();

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
            future: loginController.invite(widget.tmpUser),
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
                    child: Text("cancel"),
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
                controller: otherIDController,
              ),
              ElevatedButton(
                onPressed: () async {},
                child: const Text("Connect"),
              ),
              ElevatedButton(
                onPressed: () async {
                  Get.dialog(
                    inviteAlert(),
                    barrierDismissible: false,
                  );
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
