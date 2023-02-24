part of photo_detail_view;

class PhotoDetailViewModel {
  final Map<DateTime, List<String>> photoMap = {};

  DateTime _dateTimeKey(DateTime dateTime) {
    return DateTime(dateTime.year, dateTime.month, dateTime.day);
  }

  void init(List<PhotoChat> photoChatList) {
    for (final chat in photoChatList) {
      final key = _dateTimeKey(chat.dateTime);
      if (!photoMap.containsKey(key)) {
        photoMap[key] = [];
      }
      photoMap[key]!.addAll(chat.photoList);
    }
  }
}
