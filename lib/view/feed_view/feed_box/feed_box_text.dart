part of feed_box;

class FeedTextBox extends FeedBox {
  FeedTextBox(this.text) : super(typeIndex: FeedBoxType.text.index);
  final String text;

  @override
  List<Object?> get props => [text];

  @override
  Map<String, dynamic> toMap() {
    return {
      "typeIndex": typeIndex,
      "text": text,
    };
  }

  factory FeedTextBox.fromMap(dynamic map) {
    final data = Map<String, dynamic>.from(map);
    return FeedTextBox(data["text"]);
  }
}
