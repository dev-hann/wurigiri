part of user_data_view;

class UserDataViewModel {
  final publicController = PublicController.find();
  final userController = UserController.find();

  Public get public => publicController.public;
  DateTime get firstMeet => public.firstMeet;
  HomeSetting get homeSetting => public.homeSetting;
  User get user => userController.user;
  User get other => userController.other;
}
