library chat_detail_view;

import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wurigiri/controller/chat_controller.dart';
import 'package:wurigiri/model/chat/chat.dart';
import 'package:wurigiri/view/chat_view/photo_detail_view.dart/photo_detail_view.dart';
import 'package:wurigiri/widget/image_view.dart';
import 'package:wurigiri/widget/photo_view/photo_view.dart';
import 'package:wurigiri/widget/title.dart';
part './chat_detail_view_model.dart';

class ChatDetailView extends StatefulWidget {
  const ChatDetailView({super.key});

  @override
  State<ChatDetailView> createState() => _ChatDetailViewState();
}

class _ChatDetailViewState extends State<ChatDetailView> {
  final ChatDetailViewModel viewModel = ChatDetailViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.init();
  }

  AppBar appBar() {
    return AppBar();
  }

  Widget photoListView() {
    final photoList = viewModel.photoList;
    return WTitle(
      onTapTitle: () {
        Get.to(PhotoDetailView(photoChatList: viewModel.photoChatList));
      },
      title: const Text("사진 및 동영상"),
      trailing: const Icon(Icons.arrow_forward_ios),
      child: SizedBox(
        height: Get.width / 4,
        child: Card(
          clipBehavior: Clip.hardEdge,
          child: Row(
            textDirection: TextDirection.rtl,
            children: photoList.sublist(0, min(photoList.length, 4)).map((e) {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 1.0,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Get.to(
                        WPhotoView.fromItem(
                          photoList: photoList.reversed.toList(),
                          initItem: e,
                        ),
                      );
                    },
                    child: WImageView(
                      CachedNetworkImageProvider(e),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            photoListView(),
          ],
        ),
      ),
    );
  }
}
