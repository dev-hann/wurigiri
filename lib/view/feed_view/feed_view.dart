import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wurigiri/controller/feed_controller.dart';
import 'package:wurigiri/controller/public_controller.dart';
import 'package:wurigiri/view/feed_view/feed_edit_view.dart';
import 'package:wurigiri/view/feed_view/feed_item_view.dart';
import 'package:wurigiri/widget/w_loading.dart';

class FeedView extends StatefulWidget {
  const FeedView({super.key});

  @override
  State<FeedView> createState() => _FeedViewState();
}

class _FeedViewState extends State<FeedView> {
  final feedController = FeedController.find();
  final publicController = PublicController.find();

  @override
  void initState() {
    super.initState();
    feedController.refreshFeedList(
      publicController.public.feedList,
    );
  }

  AppBar appBar() {
    return AppBar(
      title: const Text("FeedView"),
      actions: [
        IconButton(
          onPressed: () async {
            final newFeed = await Get.to(FeedEditView());
            if (newFeed == null) {
              return;
            }
            await feedController.updateFeed(
              newFeed: newFeed,
            );
            final newPublic = publicController.public.copyWith(
              feedList: feedController.feedIndexList,
            );
            publicController.updatePublic(newPublic);
          },
          icon: const Icon(Icons.edit),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: GetBuilder<FeedController>(builder: (controller) {
        final list = controller.feedList;
        if (list.isEmpty) {
          return const WLoading();
        }
        return ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            return FeedItemView(
              feed: list[index],
              onTapRemove: (feedIndex) {
                feedController.removeFeed(feedIndex);
                final newPublic = publicController.public.copyWith(
                  feedList: feedController.feedIndexList,
                );
                publicController.updatePublic(newPublic);
              },
            );
          },
        );
      }),
    );
  }
}
