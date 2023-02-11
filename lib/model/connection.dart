import 'package:equatable/equatable.dart';

class Connection extends Equatable {
  const Connection({
    required this.publicID,
    required this.invitator,
    required this.guest,
  });
  final String publicID;
  final String invitator;
  final String guest;

  @override
  List<Object?> get props => [
        publicID,
        invitator,
        guest,
      ];

  Map<String, dynamic> toMap() {
    return {
      "publicID": publicID,
      "invitator": invitator,
      "guest": guest,
    };
  }

  factory Connection.fromMap(dynamic map) {
    final data = Map<String, dynamic>.from(map);
    return Connection(
      publicID: data["publicID"],
      invitator: data["invitator"],
      guest: data["guest"],
    );
  }
  Connection copyWith({
    String? publicID,
    String? invitator,
    String? guest,
  }) {
    return Connection(
      publicID: publicID ?? this.publicID,
      invitator: invitator ?? this.invitator,
      guest: guest ?? this.guest,
    );
  }
}
