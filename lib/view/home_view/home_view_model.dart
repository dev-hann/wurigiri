import 'package:get/get.dart';
import 'package:wurigiri/controller/calendar_controller.dart';
import 'package:wurigiri/controller/chat_controller.dart';
import 'package:wurigiri/controller/controller.dart';
import 'package:wurigiri/controller/feed_controller.dart';
import 'package:wurigiri/controller/file_controller.dart';
import 'package:wurigiri/controller/notify_controller.dart';
import 'package:wurigiri/controller/public_controller.dart';
import 'package:wurigiri/controller/user_controller.dart';
import 'package:wurigiri/repo/calendar/calendar_repo.dart';
import 'package:wurigiri/repo/chat/chat_repo.dart';
import 'package:wurigiri/repo/feed/feed_repo.dart';
import 'package:wurigiri/repo/file/file_repo.dart';
import 'package:wurigiri/repo/notify/notify_repo.dart';
import 'package:wurigiri/repo/public/public_repo.dart';
import 'package:wurigiri/widget/image_picker.dart';

class HomeViewModel {
  final userController = UserController.find();
  late final FileController fileController;
  late final PublicController publicController;
  void init() async {
    final publicID = userController.publicID;
    userController.reqeustOther();
    Controller.put(
      ChatController(ChatImpl(publicID)),
    );
    Controller.put(
      FeedController(FeedImpl(publicID)),
    );

    Controller.put(
      CalendarController(CalendarImpl(publicID)),
    );
    publicController = await Controller.put(
      PublicController(PublicImpl(publicID)),
    );
    fileController = await Controller.put(
      FileController(FileImpl()),
    );
    Get.put(NotifyController(NotifyImpl()));
  }

  String get backgroundURL => publicController.public.mainPhoto;

  Future<void> updateBackgroundPhoto() async {
    final res = await WImagePicker.pickImage();
    if (res == null) {
      return;
    }
    Controller.overlayLoading(
      asyncFunction: () async {
        final public = publicController.public;
        final url = await fileController.uploadFile(
          res.path,
          removePath: public.mainPhoto,
        );
        await publicController.updatePublic(
          public.copyWith(mainPhoto: url),
        );
        return true;
      },
    );
  }

  void removeBackgroundPhoto() {
    Controller.overlayLoading(
      asyncFunction: () async {
        final public = publicController.public;
        if (public.mainPhoto.isNotEmpty) {
          fileController.removeFile(public.mainPhoto);
        }
        await publicController.updatePublic(
          public.copyWith(mainPhoto: ""),
        );
      },
    );
  }
}
