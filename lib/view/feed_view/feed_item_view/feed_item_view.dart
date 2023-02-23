library feed_item_view;

import 'package:flutter/material.dart';
import 'package:wurigiri/model/feed.dart';
import 'package:wurigiri/util/time_format.dart';
import 'package:wurigiri/widget/image_layout.dart';

class FeedItemView extends StatefulWidget {
  const FeedItemView({
    super.key,
    required this.feed,
    required this.onTapRemove,
    required this.onTaPhoto,
  });
  final Feed feed;
  final Function(String index) onTapRemove;
  final Function(int index) onTaPhoto;

  @override
  State<FeedItemView> createState() => _FeedItemViewState();
}

class _FeedItemViewState extends State<FeedItemView>
    with AutomaticKeepAliveClientMixin {
  Widget titleText() {
    return Text(
      widget.feed.title,
      style: const TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w600,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget dateTimeText() {
    return Text(
      WTimeFormat(widget.feed.dateTime).dateFormat,
      style: const TextStyle(
        fontSize: 10.0,
        fontWeight: FontWeight.w300,
      ),
    );
  }

  Widget photoView() {
    return WImageLayOut(
      imageList: widget.feed.thumbList.map((e) => MemoryImage(e)).toList(),
      onTapPhoto: widget.onTaPhoto,
    );
  }

  Widget emojiWidget() {
    return const Icon(Icons.favorite_border);
  }

  Widget descText() {
    return Text(
      widget.feed.desc,
      textAlign: TextAlign.left,
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: titleText(),
                ),
                dateTimeText(),
              ],
            ),
            const SizedBox(height: 8.0),
            photoView(),
            const SizedBox(height: 8.0),
            emojiWidget(),
            const SizedBox(height: 8.0),
            descText(),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
