part of feed_box;

class FeedPhotoBox extends FeedBox {
  FeedPhotoBox(this.photoList) : super(typeIndex: FeedBoxType.photo.index);

  final List<String> photoList;
  @override
  List<Object?> get props => [photoList];

  @override
  Map<String, dynamic> toMap() {
    return {
      "typeIndex": typeIndex,
      "photoList": photoList,
    };
  }

  factory FeedPhotoBox.fromMap(dynamic map) {
    final data = Map<String, dynamic>.from(map);
    return FeedPhotoBox(data["photoList"]);
  }
}
