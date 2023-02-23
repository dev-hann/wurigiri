import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wurigiri/consts/const.dart';
import 'package:wurigiri/controller/feed_controller.dart';
import 'package:wurigiri/view/feed_view/feed_edit_view/feed_edit_view.dart';
import 'package:wurigiri/view/feed_view/feed_item_view/feed_item_view.dart';
import 'package:wurigiri/view/feed_view/feed_view_model.dart';
import 'package:wurigiri/widget/background.dart';
import 'package:wurigiri/widget/loading.dart';
import 'package:wurigiri/widget/photo_view/photo_view.dart';

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
      title: const Text("50𝓚𝓖𝓻𝓪𝓶"),
      actions: [
        IconButton(
          onPressed: () async {},
          icon: const Icon(Icons.search),
        ),
      ],
    );
  }

  Widget newFeedButton() {
    return FloatingActionButton(
      backgroundColor: Colors.white,
      onPressed: () async {
        final newFeed = await Get.to(FeedEditView());
        if (newFeed == null) {
          return;
        }
        viewModel.updateFeed(newFeed);
      },
      child: Icon(
        Icons.edit,
        color: WColor.black,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WBackground(
      child: Scaffold(
        floatingActionButton: newFeedButton(),
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
              return PageView.builder(
                physics: const BouncingScrollPhysics(),
                pageSnapping: false,
                controller: viewModel.pageController,
                itemCount: list.length,
                itemBuilder: (context, index) {
                  final feed = list[index];
                  return Align(
                    alignment: const Alignment(0, -0.4),
                    child: AnimatedScale(
                      duration: const Duration(milliseconds: 300),
                      scale: viewModel.currentPage == index ? 1.1 : 1,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: FeedItemView(
                          feed: feed,
                          onTapRemove: (index) {},
                          onTaPhoto: (index) {
                            Get.to(
                              WPhotoView(
                                photoList: feed.photoList,
                                initIndex: index,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
