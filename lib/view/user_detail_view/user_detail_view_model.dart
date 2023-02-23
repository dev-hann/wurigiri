import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wurigiri/controller/controller.dart';
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

  void editHeadPhoto(
    ImageSource source,
  ) async {
    final res = await WImagePicker.pickImage(
      source: source,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
      ],
    );
    if (res == null) {
      return;
    }
    Controller.overlayLoading(
      asyncFunction: () async {
        final userHeadPhoto = user.headPhoto;
        final headPhotoURL = await fileController.uploadFile(
          res.path,
          removePath: userHeadPhoto,
        );
        final newUser = user.copyWith(
          headPhoto: headPhotoURL,
        );
        user = newUser;
        userController.updateUser(
          newUser,
          withServer: true,
        );
        return true;
      },
    );
  }

  void removeHeadPhoto() {
    final userHeadPhoto = user.headPhoto;
    fileController.removeFile(userHeadPhoto);
    final newUser = user.copyWith(
      headPhoto: "",
    );
    user = newUser;
    userController.updateUser(
      newUser,
      withServer: true,
    );
  }

  Future<void> updateName() async {
    final text = nameController.text;
    if (text == user.name) {
      return;
    }
    await Future.delayed(Duration.zero);
    final newUser = user.copyWith(
      name: text,
    );
    userController.updateUser(
      newUser,
      withServer: true,
    );
  }
}
