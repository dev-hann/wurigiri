import 'package:get/get.dart';
import 'package:wurigiri/controller/controller.dart';
import 'package:wurigiri/repo/file/file_repo.dart';

class FileController extends Controller<FileRepo> {
  FileController(super.repo);

  static FileController find() => Get.find<FileController>();

  Future<String> uploadFile(
    String filePath, {
    String? removePath,
  }) async {
    if (removePath != null && removePath.isNotEmpty) {
      removeFile(removePath);
    }
    return repo.uploadFile(filePath);
  }

  Future removeFile(String fileURL) {
    final index = fileURL.split("/").last.split("?").first;
    return repo.removeFile(index);
  }
}
