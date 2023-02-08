import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class WImagePicker {
  static final ImagePicker _picker = ImagePicker();
  static final ImageCropper _cropper = ImageCropper();
  static Future<String?> pickImage({
    ImageSource source = ImageSource.gallery,
    List<CropAspectRatioPreset> aspectRatioPresets = const [],
  }) async {
    final file = await _picker.pickImage(
      source: source,
      imageQuality: 70,
    );
    if (file == null) {
      return null;
    }
    if (aspectRatioPresets.isEmpty) {
      return file.path;
    }
    final crooped = await _cropper.cropImage(
      sourcePath: file.path,
      aspectRatioPresets: aspectRatioPresets,
    );
    if (crooped == null) {
      return null;
    }
    return crooped.path;
  }
}
