import 'package:get/get.dart';
import 'package:wurigiri/controller/chat_controller.dart';
import 'package:wurigiri/controller/controller.dart';
import 'package:wurigiri/controller/feed_controller.dart';
import 'package:wurigiri/controller/file_controller.dart';
import 'package:wurigiri/controller/notify_controller.dart';
import 'package:wurigiri/controller/public_controller.dart';
import 'package:wurigiri/controller/user_controller.dart';
import 'package:wurigiri/repo/chat/chat_repo.dart';
import 'package:wurigiri/repo/feed/feed_repo.dart';
import 'package:wurigiri/repo/file/file_repo.dart';
import 'package:wurigiri/repo/notify/notify_repo.dart';
import 'package:wurigiri/repo/public/public_repo.dart';

class HomeViewModel {
  final userController = UserController.find();
  void init() async {
    final publicID = userController.publicID;
    userController.reqeustOther();
    await Controller.put<ChatController>(
      ChatController(ChatImpl(publicID)),
    );
    await Controller.put<FileController>(
      FileController(FileImpl()),
    );
    await Controller.put<PublicController>(
      PublicController(PublicImpl(publicID)),
    );
    Get.put(
      FeedController(FeedImpl(publicID)),
    );
    Get.put(
      NotifyController(NotifyImpl()),
    );
  }
}
