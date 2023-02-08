import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wurigiri/widget/head_photo.dart';

class SettingView extends StatelessWidget {
  const SettingView({super.key});

  AppBar appBar() {
    return AppBar(
      title: const Text("Setting View"),
    );
  }

  Widget headPhoto() {
    return HeadPhoto(
      "",
      badge: GestureDetector(
        onTap: () async {
          final ImagePicker _picker = ImagePicker();
          final file = await _picker.pickImage(source: ImageSource.gallery);
          if (file == null) {
            return;
          }
          print(file);
        },
        child: const Icon(Icons.camera),
      ),
    );
  }

  Widget nameText() {
    return TextField();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Column(
        children: [
          headPhoto(),
          nameText(),
        ],
      ),
    );
  }
}
