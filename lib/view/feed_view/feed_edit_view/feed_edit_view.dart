import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reorderables/reorderables.dart';
import 'package:wurigiri/controller/feed_controller.dart';
import 'package:wurigiri/model/w_image.dart';
import 'package:wurigiri/view/feed_view/feed_edit_view/feed_edit_view_model.dart';
import 'package:wurigiri/widget/background.dart';
import 'package:badges/badges.dart' as badges;

class FeedEditView extends StatelessWidget {
  FeedEditView({super.key});
  final FeedEditViewModel viewModel = FeedEditViewModel();
  AppBar appBar() {
    return AppBar(
      title: Text("FeedEditView!!"),
      actions: [
        IconButton(
          onPressed: () async {
            FocusManager.instance.primaryFocus?.unfocus();
            final newFeed = await viewModel.updateFeed();
            Get.back(result: newFeed);
          },
          icon: const Icon(Icons.upload),
        ),
      ],
    );
  }

  Widget titleView() {
    return TextField(
      controller: viewModel.titleController,
      decoration: const InputDecoration(
        hintText: "Aa",
        border: InputBorder.none,
      ),
    );
  }

  Widget photoListView() {
    final list = viewModel.photoList;

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

    final size = Get.width / 4;
    return ReorderableWrap(
      onReorder: (int oldIndex, int newIndex) {},
      footer: addIcon(),
      children: [
        for (int index = 0; index < list.length; index++)
          SizedBox.square(
            dimension: size,
            child: Card(
              clipBehavior: Clip.hardEdge,
              child: Image.memory(
                list[index].thumbData,
                fit: BoxFit.cover,
              ),
            ),
          ),
      ],
    );
  }

  Widget descView() {
    return TextField(
      expands: true,
      maxLines: null,
      minLines: null,
      controller: viewModel.descController,
      decoration: const InputDecoration(
        hintText: "Desc..",
        border: InputBorder.none,
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
            body: SingleChildScrollView(
              child: Column(
                children: [
                  photoListView(),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        titleView(),
                        const Divider(height: 1),
                        SizedBox(
                          height: Get.height / 3,
                          child: descView(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
