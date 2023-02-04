import 'package:get/get.dart';
import 'package:wurigiri/model/public.dart';
import 'package:wurigiri/repo/public/public_repo.dart';

class PublicController extends GetxController {
  PublicController(
    this.publicRepo,
  );

  static PublicController find() => Get.find<PublicController>();

  final PublicRepo publicRepo;

  Public public = Public.empty();

  @override
  void onReady() async {
    super.onReady();
    _initPublicStream();
  }

  void _initPublicStream() {
    publicRepo.publicStream.listen((event) {
      if (event.isEmpty) {
        public = Public.empty();
      } else {
        public = Public.fromMap(event);
      }
      update();
    });
  }

  Future updatePublic(Public newPublic) async {
    await publicRepo.updatePublic(newPublic.toMap());
  }
}
