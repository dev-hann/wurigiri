import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    this.publicID = "",
    required this.id,
    required this.name,
    required this.headPhoto,
  });
  final String publicID;
  final String id;
  final String name;
  final String headPhoto;

  factory User.fromMap(dynamic map) {
    final data = Map<String, dynamic>.from(map);
    return User(
      publicID: data["publicID"],
      id: data["id"],
      name: data["name"],
      headPhoto: data["headPhoto"],
    );
  }

  @override
  List<Object?> get props => [
        publicID,
        id,
        name,
        headPhoto,
      ];

  Map<String, dynamic> toMap() {
    return {
      "publicID": publicID,
      "id": id,
      "name": name,
      "headPhoto": headPhoto,
    };
  }

  User copyWith({
    String? publicID,
    String? id,
    String? name,
    String? headPhoto,
  }) {
    return User(
      publicID: publicID ?? this.publicID,
      id: id ?? this.id,
      name: name ?? this.name,
      headPhoto: headPhoto ?? this.headPhoto,
    );
  }
}
