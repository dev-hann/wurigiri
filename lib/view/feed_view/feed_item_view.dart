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
            Text(feed.dateTime.toString()),
            const SizedBox(height: 8.0),
            Expanded(
              flex: 8,
              child: ColoredBox(
                color: Colors.grey.withOpacity(0.2),
                child: SizedBox.expand(),
              ),
            ),
            const SizedBox(height: 8.0),
            Expanded(
              flex: 2,
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  feed.desc,
                  textAlign: TextAlign.left,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
