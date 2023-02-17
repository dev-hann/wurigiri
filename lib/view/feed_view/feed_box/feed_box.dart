library feed_box;

import 'package:equatable/equatable.dart';

part './feed_box_text.dart';
part './feed_box_photo.dart';

enum FeedBoxType {
  text,
  photo,
}

abstract class FeedBox extends Equatable {
  const FeedBox({
    required this.typeIndex,
  });
  final int typeIndex;

  FeedBoxType get type => FeedBoxType.values[typeIndex];

  Map<String, dynamic> toMap();

  static FeedBox fromMap(dynamic map) {
    final data = Map<String, dynamic>.from(map);
    final type = FeedBoxType.values[data["typeIndex"]];
    switch (type) {
      case FeedBoxType.text:
        return FeedTextBox.fromMap(map);
      case FeedBoxType.photo:
        return FeedPhotoBox.fromMap(map);
    }
  }
}
