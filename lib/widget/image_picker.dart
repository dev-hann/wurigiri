import 'dart:typed_data';

import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:wurigiri/model/w_image.dart';

class WImagePicker {
  static final ImagePicker _picker = ImagePicker();
  static final ImageCropper _cropper = ImageCropper();
  static Future<WImage?> pickImage({
    ImageSource source = ImageSource.gallery,
    List<CropAspectRatioPreset> aspectRatioPresets = const [],
  }) async {
    final file = await _picker.pickImage(
      source: source,
    );
    if (file == null) {
      return null;
    }
    final filePath = file.path;
    if (aspectRatioPresets.isEmpty) {
      final data = await _compress(filePath);
      if (data == null) {
        return null;
      }
      return WImage(path: filePath, thumbData: data);
    }
    final crooped = await _cropper.cropImage(
      sourcePath: filePath,
      aspectRatioPresets: aspectRatioPresets,
    );
    if (crooped == null) {
      return null;
    }
    final croppedData = await _compress(crooped.path);
    if (croppedData == null) {
      return null;
    }
    return WImage(path: crooped.path, thumbData: croppedData);
  }

  static Future<Uint8List?> _compress(String filePath) {
    return FlutterImageCompress.compressWithFile(
      filePath,
      quality: 20,
      minWidth: 50,
      minHeight: 50,
    );
  }
}
