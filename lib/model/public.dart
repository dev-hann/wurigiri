import 'package:equatable/equatable.dart';

class Public extends Equatable {
  const Public({
    required this.mainPhoto,
  });
  final String mainPhoto;

  factory Public.empty() {
    return const Public(
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

  factory Public.fromMap(dynamic map) {
    final data = Map<String, dynamic>.from(map);
    return Public(
      mainPhoto: data["mainPhoto"],
    );
  }

  Public copyWith({
    String? mainPhoto,
    List<String>? feedList,
  }) {
    return Public(
      mainPhoto: mainPhoto ?? this.mainPhoto,
    );
  }
}
