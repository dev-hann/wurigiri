import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    this.publicID = "",
    required this.id,
    required this.name,
    required this.headPhoto,
    this.otherID = "",
  });
  final String publicID;
  final String id;
  final String name;
  final String headPhoto;
  final String otherID;

  factory User.fromMap(dynamic map) {
    final data = Map<String, dynamic>.from(map);
    return User(
      publicID: data["publicID"],
      id: data["id"],
      name: data["name"],
      headPhoto: data["headPhoto"],
      otherID: data["otherID"],
    );
  }

  @override
  List<Object?> get props => [
        publicID,
        id,
        name,
        headPhoto,
        otherID,
      ];

  Map<String, dynamic> toMap() {
    return {
      "publicID": publicID,
      "id": id,
      "name": name,
      "headPhoto": headPhoto,
      "otherID": otherID,
    };
  }

  User copyWith({
    String? publicID,
    String? id,
    String? name,
    String? headPhoto,
    String? otherID,
  }) {
    return User(
      publicID: publicID ?? this.publicID,
      id: id ?? this.id,
      name: name ?? this.name,
      headPhoto: headPhoto ?? this.headPhoto,
      otherID: otherID ?? this.otherID,
    );
  }
}
