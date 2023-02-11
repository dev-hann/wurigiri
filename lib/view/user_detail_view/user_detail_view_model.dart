import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:wurigiri/controller/user_controller.dart';
import 'package:wurigiri/model/user.dart';
import 'package:wurigiri/widget/image_picker.dart';
import 'package:wurigiri/controller/file_controller.dart';

class UserDetailViewModel {
  final userController = UserController.find();
  final fileController = FileController.find();

  late User user;
  late final bool isOther;
  final nameController = TextEditingController();

  void init(User user) {
    this.user = user;
    nameController.text = user.name;
    isOther = userController.other.id == user.id;
  }

  void editHeadPhoto() async {
    final res = await WImagePicker.pickImage(
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
      ],
    );
    if (res == null) {
      return;
    }
    userController.loadingOverlay(
      asyncFunction: () async {
        final headPhotoURL = await fileController.uploadFile(res.path);
        final userHeadPhoto = user.headPhoto;
        if (userHeadPhoto.isNotEmpty) {
          fileController.removeFile(userHeadPhoto);
        }
        final newUser = user.copyWith(
          headPhoto: headPhotoURL,
        );
        user = newUser;
        userController.updateUser(
          newUser,
          withServer: true,
        );
        userController.update();
        return true;
      },
    );
  }

  void updateName() {
    final text = nameController.text;
    final newUser = user.copyWith(
      name: text,
    );
    user = newUser;
    userController.updateUser(
      newUser,
      withServer: true,
    );
  }
}
