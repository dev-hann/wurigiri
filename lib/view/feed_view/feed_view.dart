import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wurigiri/controller/feed_controller.dart';
import 'package:wurigiri/view/feed_view/feed_edit_view/feed_edit_view.dart';
import 'package:wurigiri/view/feed_view/feed_item_view.dart';
import 'package:wurigiri/view/feed_view/feed_view_model.dart';
import 'package:wurigiri/widget/background.dart';
import 'package:wurigiri/widget/loading.dart';

class FeedView extends StatefulWidget {
  const FeedView({super.key});

  @override
  State<FeedView> createState() => _FeedViewState();
}

class _FeedViewState extends State<FeedView> {
  final FeedViewModel viewModel = FeedViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.init();
  }

  AppBar appBar() {
    return AppBar(
      title: const Text("FeedView"),
      actions: [
        IconButton(
          onPressed: () async {},
          icon: const Icon(Icons.search),
        ),
        IconButton(
          onPressed: () async {
            final newFeed = await Get.to(FeedEditView());
            if (newFeed == null) {
              return;
            }
            viewModel.updateFeed(newFeed);
          },
          icon: const Icon(Icons.edit),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return WBackground(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        appBar: appBar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: GetBuilder<FeedController>(
            builder: (controller) {
              final list = viewModel.feedList;
              if (list.isEmpty) {
                return const WLoading();
              }
              return Align(
                alignment: const Alignment(0, -0.4),
                child: CarouselSlider.builder(
                  options: CarouselOptions(
                    aspectRatio: 0.8,
                    enlargeCenterPage: true,
                    enlargeFactor: 0.2,
                    viewportFraction: 0.8,
                    enableInfiniteScroll: true,
                  ),
                  itemCount: list.length,
                  itemBuilder: (context, index, realIndex) {
                    final feed = list[index];
                    return FeedItemView(
                      feed: feed,
                      onTapRemove: (feedIndex) {},
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
