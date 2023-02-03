import 'package:equatable/equatable.dart';

class Connection extends Equatable {
  const Connection({
    required this.invitator,
    required this.guest,
  });
  final bool invitator;
  final bool guest;

  @override
  List<Object?> get props => [
        invitator,
        guest,
      ];

  Map<String, dynamic> toMap() {
    return {
      "invitator": invitator,
      "guest": guest,
    };
  }

  factory Connection.fromMap(dynamic map) {
    final data = Map<String, dynamic>.from(map);
    return Connection(
      invitator: data["invitator"],
      guest: data["guest"],
    );
  }
  Connection copyWith({
    bool? invitator,
    bool? guest,
  }) {
    return Connection(
      invitator: invitator ?? this.invitator,
      guest: guest ?? this.guest,
    );
  }
}
