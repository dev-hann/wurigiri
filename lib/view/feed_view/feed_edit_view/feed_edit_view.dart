import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wurigiri/controller/feed_controller.dart';
import 'package:wurigiri/model/w_image.dart';
import 'package:wurigiri/view/feed_view/feed_edit_view/feed_edit_view_model.dart';
import 'package:wurigiri/widget/background.dart';

class FeedEditView extends StatelessWidget {
  FeedEditView({super.key});
  final FeedEditViewModel viewModel = FeedEditViewModel();
  AppBar appBar() {
    return AppBar(
      title: Text("FeedEditView!!"),
      actions: [
        IconButton(
          onPressed: () async {
            final newFeed = await viewModel.updateFeed();
            Get.back(result: newFeed);
          },
          icon: Icon(Icons.upload),
        ),
      ],
    );
  }

  Widget titleView() {
    return TextField(
      controller: viewModel.titleController,
      decoration: InputDecoration(
        hintText: "title",
      ),
    );
  }

  Widget photoListView() {
    Widget photoView(WImage image) {
      return Card(
        child: Image.memory(
          image.thumbData,
          fit: BoxFit.contain,
        ),
      );
    }

    Widget addIcon() {
      return Center(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100.0),
          ),
          child: IconButton(
            onPressed: () {
              viewModel.pickPhotoList();
            },
            icon: const Icon(Icons.add),
          ),
        ),
      );
    }

    return CarouselSlider(
      options: CarouselOptions(
        enableInfiniteScroll: false,
        viewportFraction: 0.5,
      ),
      items: [
        ...viewModel.photoList.map(photoView).toList(),
        addIcon(),
      ],
    );
  }

  Widget descView() {
    return TextField(
      controller: viewModel.descController,
      decoration: InputDecoration(
        hintText: "Desc",
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WBackground(
      child: GetBuilder<FeedController>(
        builder: (controller) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            appBar: appBar(),
            body: Column(
              children: [
                titleView(),
                photoListView(),
                descView(),
              ],
            ),
          );
        },
      ),
    );
  }
}
