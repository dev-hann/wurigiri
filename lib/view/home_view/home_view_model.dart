part of home_view;

class HomeViewModel {
  final userController = UserController.find();
  late final FileController fileController;
  late final PublicController publicController;
  bool isLoading = true;
  void init() async {
    final publicID = userController.publicID;
    userController.reqeustOther();
    await Controller.put(
      ChatController(ChatImpl(publicID)),
    );
    await Controller.put(
      FeedController(FeedImpl(publicID)),
    );

    await Controller.put(
      CalendarController(CalendarImpl(publicID)),
    );
    publicController = await Controller.put(
      PublicController(PublicImpl(publicID)),
    );
    fileController = await Controller.put(
      FileController(FileImpl()),
    );
    Get.put(NotifyController(NotifyImpl()));
    isLoading = false;
    userController.update();
  }

  User get user => userController.user;
  User get other => userController.other;
  Public get public => publicController.public;
  DateTime get firstMeet => public.firstMeet;
  HomeSetting get homeSetting => public.homeSetting;
  String get mainPhotoURL => homeSetting.photo;

  Future<void> updateHomePhoto() async {
    final res = await WImagePicker.pickImage();
    if (res == null) {
      return;
    }
    await Controller.overlayLoading(
      asyncFunction: () async {
        final url = await fileController.uploadFile(
          res.path,
          removePath: mainPhotoURL,
        );
        await publicController.updateHomeSetting(
          homeSetting.copyWith(photo: url),
        );
        publicController.update();
        return true;
      },
    );
  }

  Future<void> removeHomePhoto() async {
    await Controller.overlayLoading(
      asyncFunction: () async {
        if (mainPhotoURL.isNotEmpty) {
          fileController.removeFile(mainPhotoURL);
        }
        await publicController.updateHomeSetting(
          homeSetting.copyWith(photo: ""),
        );
        publicController.update();
      },
    );
  }
}
