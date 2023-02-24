part of public;

class HomeSetting extends Equatable {
  const HomeSetting({
    required this.photo,
    required this.showFristMeetDateTime,
    required this.showDDay,
  });
  final String photo;
  final bool showFristMeetDateTime;
  final bool showDDay;

  @override
  List<Object?> get props => [
        photo,
        showDDay,
        showFristMeetDateTime,
      ];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'photo': photo,
      'showFristMeetDateTime': showFristMeetDateTime,
      'showDDay': showDDay,
    };
  }

  factory HomeSetting.fromMap(Map<String, dynamic> map) {
    return HomeSetting(
      photo: map['photo'] as String,
      showFristMeetDateTime: map['showFristMeetDateTime'] as bool,
      showDDay: map['showDDay'] as bool,
    );
  }

  factory HomeSetting.empty() {
    return const HomeSetting(
      photo: "",
      showFristMeetDateTime: true,
      showDDay: true,
    );
  }

  HomeSetting copyWith({
    String? photo,
    bool? showFristMeetDateTime,
    bool? showDDay,
  }) {
    return HomeSetting(
      photo: photo ?? this.photo,
      showFristMeetDateTime:
          showFristMeetDateTime ?? this.showFristMeetDateTime,
      showDDay: showDDay ?? this.showDDay,
    );
  }
}
