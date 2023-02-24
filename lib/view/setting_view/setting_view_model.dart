import 'package:wurigiri/controller/controller.dart';
import 'package:wurigiri/controller/file_controller.dart';
import 'package:wurigiri/controller/public_controller.dart';
import 'package:wurigiri/controller/user_controller.dart';
import 'package:wurigiri/model/public/public.dart';

class SettingViewModel {
  final usercontroller = UserController.find();
  final fileController = FileController.find();
  final publicController = PublicController.find();

  Public get public => publicController.public;
  HomeSetting get homeSetting => public.homeSetting;

  void updateFirstMeet(DateTime dateTime) async {
    Controller.overlayLoading(
      asyncFunction: () async {
        await publicController.updatePublic(
          public.copyWith(firstMeet: dateTime),
        );
        publicController.update();
      },
    );
  }

  Future updateHomeSetting(HomeSetting homeSetting) {
    return Controller.overlayLoading(
      asyncFunction: () async {
        await publicController.updateHomeSetting(homeSetting);
        publicController.update();
      },
    );
  }
}
