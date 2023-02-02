import 'package:get/get.dart';
import 'package:wurigiri/model/setting.dart';
import 'package:wurigiri/repo/setting/setting_repo.dart';

class SettingController extends GetxController {
  SettingController(
    this.settingRepo,
  );

  static SettingController find() => Get.find<SettingController>();

  final SettingRepo settingRepo;

  Setting? setting;
  bool get isLoading => setting == null;

  @override
  void onReady() async {
    super.onReady();
    _initSettingStream();
  }

  void _initSettingStream() {
    settingRepo.settingStream.listen((event) {
      if (event == null) {
        setting = Setting.empty();
      } else {
        setting = Setting.fromMap(event);
      }
      update();
    });
  }

  Future updateSetting(Setting newSetting) async {
    await settingRepo.updateSetting(newSetting.toMap());
  }
}
