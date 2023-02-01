import 'package:get/get.dart';
import 'package:wurigiri/model/setting.dart';
import 'package:wurigiri/repo/fire/fire_repo.dart';
import 'package:wurigiri/repo/notify/notify_repo.dart';

class SettingController extends GetxController {
  SettingController(
    this.settingRepo,
    this.fireRepo,
  );

  static SettingController find() => Get.find<SettingController>();

  final FireRepo fireRepo;
  final NotifyRepo settingRepo;

  Setting? setting;
  bool get isLoading => setting == null;

  @override
  void onReady() async {
    super.onReady();
    _initSettingStream();
  }

  void _initSettingStream() {
    fireRepo.settingStream.listen((event) {
      if (event == null) {
        setting = Setting.empty();
      } else {
        setting = Setting.fromMap(event);
      }
      update();
    });
  }

  Future updateSetting(Setting newSetting) async {
    await fireRepo.updateSetting(newSetting.toMap());
  }
}
