part of file_repo;

class FileImpl extends FileRepo {
  final Service service = Service();

  @override
  Future init() async {}

  @override
  Future<String> uploadFile(String filePath) {
    return service.uploadFile(filePath);
  }

  @override
  Future removeFile(String fileName) {
    return service.removeFile(fileName);
  }
}
