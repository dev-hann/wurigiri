import 'dart:typed_data';

import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:wurigiri/model/w_image.dart';

class WImagePicker {
  static final ImagePicker _picker = ImagePicker();
  static final ImageCropper _cropper = ImageCropper();

  static Future<List<WImage>> pickImageList({
    ImageSource source = ImageSource.gallery,
    CompressOption option = const CompressOption.feed(),
  }) async {
    final itemList = await _picker.pickMultiImage();
    if (itemList.isEmpty) {
      return [];
    }
    final res = <WImage>[];
    for (final item in itemList) {
      final path = item.path;
      final data = await _compress(path, option: option);
      if (data == null) {
        continue;
      }
      res.add(
        WImage(path: path, thumbData: data),
      );
    }
    return res;
  }

  static Future<WImage?> pickImage({
    ImageSource source = ImageSource.gallery,
    List<CropAspectRatioPreset> aspectRatioPresets = const [],
    CompressOption option = const CompressOption.feed(),
  }) async {
    final file = await _picker.pickImage(source: source, imageQuality: 70);
    if (file == null) {
      return null;
    }
    final filePath = file.path;
    if (aspectRatioPresets.isEmpty) {
      final data = await _compress(filePath, option: option);
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
    final croppedData = await _compress(crooped.path, option: option);
    if (croppedData == null) {
      return null;
    }
    return WImage(path: crooped.path, thumbData: croppedData);
  }

  static Future<Uint8List?> _compress(String filePath,
      {required CompressOption option}) {
    return FlutterImageCompress.compressWithFile(
      filePath,
      quality: option.quilty,
      minWidth: option.minWidth,
      minHeight: option.minHeight,
    );
  }
}

class CompressOption {
  const CompressOption(
    this.quilty,
    this.minWidth,
    this.minHeight,
  );
  final int quilty;
  final int minWidth;
  final int minHeight;

  const CompressOption.headPhoto()
      : quilty = 20,
        minWidth = 50,
        minHeight = 50;

  const CompressOption.feed()
      : quilty = 80,
        minWidth = 500,
        minHeight = 500;
}
