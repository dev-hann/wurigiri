import 'package:get/get.dart';
import 'package:wurigiri/model/notify.dart';
import 'package:wurigiri/repo/notify/notify_repo.dart';

class NotifyController extends GetxController {
  NotifyController(this.notifyRepo);

  static NotifyController find() => Get.find<NotifyController>();

  final NotifyRepo notifyRepo;
  Notify notify = Notify.empty();

  @override
  void onReady() {
    _initNotifyStream();
    super.onReady();
  }

  void _initNotifyStream() {
    notifyRepo.notifyStream().listen((event) {
      final newNotify = Notify.fromMap(event);
      if (notify != newNotify) {
        notify = newNotify;
        update();
      }
    });
  }

  Future updateNotofy(Notify newNotify) {
    return notifyRepo.updateNotify(newNotify.toMap());
  }
}
