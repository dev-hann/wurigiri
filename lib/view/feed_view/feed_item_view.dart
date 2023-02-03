import 'package:flutter/material.dart';
import 'package:wurigiri/model/feed.dart';

class FeedItemView extends StatelessWidget {
  const FeedItemView({
    super.key,
    required this.feed,
    required this.onTapRemove,
  });
  final Feed feed;
  final Function(String index) onTapRemove;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Text(feed.title),
                IconButton(
                  onPressed: () {
                    onTapRemove(feed.index);
                  },
                  icon: const Icon(Icons.delete),
                )
              ],
            ),
            Text(feed.dateTime.toString()),
            Text(feed.desc),
          ],
        ),
      ),
    );
  }
}
