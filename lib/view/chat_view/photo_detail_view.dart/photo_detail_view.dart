library photo_detail_view;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wurigiri/model/chat/chat.dart';
import 'package:wurigiri/util/time_format.dart';
import 'package:wurigiri/widget/image_view.dart';
import 'package:wurigiri/widget/title.dart';

part './photo_detail_view_model.dart';

class PhotoDetailView extends StatefulWidget {
  const PhotoDetailView({
    super.key,
    required this.photoChatList,
  });
  final List<PhotoChat> photoChatList;

  @override
  State<PhotoDetailView> createState() => _PhotoDetailViewState();
}

class _PhotoDetailViewState extends State<PhotoDetailView> {
  final PhotoDetailViewModel viewModel = PhotoDetailViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.init(widget.photoChatList);
  }

  AppBar appBar() {
    return AppBar();
  }

  Widget photoItemnWidget({
    required DateTime dateTime,
    required List<String> photoList,
  }) {
    return WTitle(
      title: Text(WTimeFormat(dateTime).dateFormat),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: photoList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
        ),
        itemBuilder: (context, index) {
          return Card(
            clipBehavior: Clip.hardEdge,
            child: WImageView(
              CachedNetworkImageProvider(photoList[index]),
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: viewModel.photoMap.entries.map((e) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: photoItemnWidget(
                dateTime: e.key,
                photoList: e.value,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
