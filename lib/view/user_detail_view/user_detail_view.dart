import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wurigiri/controller/user_controller.dart';
import 'package:wurigiri/model/user.dart';
import 'package:wurigiri/view/user_detail_view/user_detail_view_model.dart';
import 'package:wurigiri/widget/bottom_sheet.dart';
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

  @override
  void dispose() {
    viewModel.updateName();
    super.dispose();
  }

  AppBar appBar() {
    return AppBar();
  }

  Widget headPhoto() {
    Widget? cameraBadge() {
      if (viewModel.isOther) {
        return null;
      }
      return const Icon(Icons.camera);
    }

    return WHeadPhoto(
      viewModel.user.headPhoto,
      badge: cameraBadge(),
      onTapBadge: () {
        WBottomSheet.image(
          onTapCamera: () {
            viewModel.editHeadPhoto(ImageSource.camera);
            Get.back();
          },
          onTapGarelly: () {
            viewModel.editHeadPhoto(ImageSource.gallery);
            Get.back();
          },
          onTapRemove: viewModel.user.headPhoto.isEmpty
              ? null
              : () {
                  viewModel.removeHeadPhoto();
                  Get.back();
                },
          onTapCancel: () {
            Get.back();
          },
        ).show(context);
        // viewModel.editHeadPhoto();
      },
    );
  }

  Widget nameTextField() {
    Widget editIcon({
      required Widget child,
    }) {
      if (viewModel.isOther) {
        return child;
      }
      const iconSize = 16.0;
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(width: iconSize),
          child,
          const Icon(
            Icons.edit,
            size: iconSize,
          ),
        ],
      );
    }

    return editIcon(
      child: SizedBox(
        width: Get.width * 0.4,
        child: AutoSizeTextField(
          enabled: !viewModel.isOther,
          controller: viewModel.nameController,
          textAlign: TextAlign.center,
          decoration: const InputDecoration(
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: appBar(),
        body: GetBuilder<UserController>(
          builder: (context) {
            return Align(
              alignment: const Alignment(0, -0.4),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  headPhoto(),
                  nameTextField(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
