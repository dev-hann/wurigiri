part of notify_repo;

class NotifyImpl extends NotifyRepo {
  Map<String, dynamic>? _tempNotify;
  final StreamController _notifyStream = StreamController.broadcast();

  @override
  dynamic loadNotify() {
    return _tempNotify;
  }

  @override
  Future updateNotify(Map<String, dynamic> data) async {
    _notifyStream.add(data);
    _tempNotify = data;
  }

  @override
  Stream<Map<String, dynamic>> notifyStream() {
    return _notifyStream.stream.map((event) {
      return Map<String, dynamic>.from(event);
    });
  }
}
