import 'dart:typed_data';

import 'package:equatable/equatable.dart';

class WImage extends Equatable {
  const WImage({
    required this.path,
    required this.thumbData,
  });
  final String path;
  final Uint8List thumbData;

  @override
  List<Object?> get props => [
        path,
        thumbData,
      ];
}
