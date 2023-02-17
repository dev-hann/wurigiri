import 'package:flutter/material.dart';
import 'package:wurigiri/controller/controller.dart';
import 'package:wurigiri/controller/feed_controller.dart';
import 'package:wurigiri/controller/file_controller.dart';
import 'package:wurigiri/model/feed.dart';
import 'package:wurigiri/model/w_image.dart';
import 'package:wurigiri/widget/image_picker.dart';

class FeedEditViewModel {
  final feedController = FeedController.find();
  final fileController = FileController.find();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final List<WImage> photoList = [];

  void pickPhotoList() async {
    final res = await WImagePicker.pickImageList();
    photoList.addAll(res);
    feedController.update();
  }

  Future<Feed> updateFeed() async {
    return Controller.overlayLoading(
      asyncFunction: () async {
        return Feed(
          title: titleController.text,
          dateTime: DateTime.now(),
          desc: descController.text,
          photoList: [],
        );
      },
    );
  }
}
