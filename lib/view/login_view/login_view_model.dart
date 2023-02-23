part of login_view;

class LoginViewModel {
  final loginController = LoginController.find();
  final userController = UserController.find();
  final idController = TextEditingController();

  Future onTapNext() async {
    await Controller.overlayLoading(asyncFunction: () async {
      final newUser = User(
        id: await loginController.requestDeviceID(),
        headPhoto: '',
        name: idController.text,
      );
      await userController.updateUser(newUser, withServer: true);
    });
  }
}
