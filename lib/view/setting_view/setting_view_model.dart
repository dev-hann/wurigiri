import 'package:wurigiri/controller/file_controller.dart';
import 'package:wurigiri/controller/public_controller.dart';
import 'package:wurigiri/controller/user_controller.dart';

class SettingViewModel {
  final usercontroller = UserController.find();
  final fileController = FileController.find();
  final publicController = PublicController.find();
}
