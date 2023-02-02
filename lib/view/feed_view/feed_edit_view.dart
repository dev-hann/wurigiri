import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:wurigiri/model/feed.dart';

class FeedEditView extends StatelessWidget {
  FeedEditView({super.key});
  final TextEditingController titleController = TextEditingController();

  final TextEditingController descController = TextEditingController();
  AppBar appBar() {
    return AppBar(
      title: Text("FeedEditView"),
      actions: [
        IconButton(
          onPressed: () {
            Get.back(
              result: Feed(
                dateTime: DateTime.now(),
                title: titleController.text,
                desc: descController.text,
              ),
            );
          },
          icon: Icon(Icons.upload),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Column(
        children: [
          TextField(
            controller: titleController,
            decoration: InputDecoration(
              hintText: "Title",
            ),
          ),
          TextField(
            controller: descController,
            decoration: InputDecoration(
              hintText: "Desc",
            ),
          ),
        ],
      ),
    );
  }
}
