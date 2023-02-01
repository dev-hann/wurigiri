import 'package:equatable/equatable.dart';

class Setting extends Equatable {
  const Setting({
    required this.mainPhoto,
  });
  final String mainPhoto;

  factory Setting.empty() {
    return const Setting(
      mainPhoto: "",
    );
  }

  @override
  List<Object?> get props => [
        mainPhoto,
      ];

  Map<String, dynamic> toMap() {
    return {
      "mainPhoto": mainPhoto,
    };
  }

  factory Setting.fromMap(dynamic map) {
    final data = Map<String, dynamic>.from(map);
    return Setting(
      mainPhoto: data["mainPhoto"],
    );
  }
}
