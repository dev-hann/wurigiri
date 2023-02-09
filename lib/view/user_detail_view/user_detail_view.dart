import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wurigiri/controller/user_controller.dart';
import 'package:wurigiri/model/user.dart';
import 'package:wurigiri/view/user_detail_view/user_detail_view_model.dart';
import 'package:wurigiri/widget/head_photo.dart';

class UserDetailView extends StatefulWidget {
  const UserDetailView({
    super.key,
    required this.user,
  });

  final User user;

  @override
  State<UserDetailView> createState() => _UserDetailViewState();
}

class _UserDetailViewState extends State<UserDetailView> {
  final UserDetailViewModel viewModel = UserDetailViewModel();
  @override
  void initState() {
    super.initState();
    viewModel.init(widget.user);
  }

  AppBar appBar() {
    return AppBar();
  }

  Widget headPhoto() {
    return WHeadPhoto(
      viewModel.user.headPhoto,
      badge: GestureDetector(
        onTap: () async {
          viewModel.editHeadPhoto();
        },
        child: const Icon(Icons.camera),
      ),
    );
  }

  Widget nameTextField() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            enabled: !viewModel.isOther,
            controller: viewModel.nameController,
          ),
        ),
        ElevatedButton(
          onPressed: () {
            viewModel.updateName();
          },
          child: const Text("Submit"),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: GetBuilder<UserController>(builder: (context) {
        return Column(
          children: [
            headPhoto(),
            nameTextField(),
          ],
        );
      }),
    );
  }
}
