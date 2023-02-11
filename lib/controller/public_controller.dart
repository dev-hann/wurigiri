import 'package:get/get.dart';
import 'package:wurigiri/controller/controller.dart';
import 'package:wurigiri/model/public.dart';
import 'package:wurigiri/repo/public/public_repo.dart';

class PublicController extends Controller<PublicRepo> {
  PublicController(super.repo);

  static PublicController find() => Get.find<PublicController>();

  Public public = Public.empty();

  @override
  void onReady() async {
    super.onReady();
    _initPublicStream();
  }

  void _initPublicStream() {
    repo.publicStream.listen((event) {
      if (event.isEmpty) {
        public = Public.empty();
      } else {
        public = Public.fromMap(event);
      }
      update();
    });
  }

  Future updatePublic(Public newPublic) async {
    await repo.updatePublic(newPublic.toMap());
  }
}
