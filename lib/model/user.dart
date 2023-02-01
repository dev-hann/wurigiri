import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    required this.id,
    required this.name,
    required this.headPhoto,
  });

  final String id;
  final String name;
  final String headPhoto;

  factory User.fromMap(dynamic map) {
    final data = Map<String, dynamic>.from(map);
    return User(
      id: data["id"],
      name: data["name"],
      headPhoto: data["headPhoto"],
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        headPhoto,
      ];

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "headPhoto": headPhoto,
    };
  }
}
