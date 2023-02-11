library file_repo;

import 'package:wurigiri/data/service.dart';
import 'package:wurigiri/repo/repo.dart';

part './file_impl.dart';

abstract class FileRepo extends Repo {
  Future<String> uploadFile(String filePath);
  Future removeFile(String fileName);
}
