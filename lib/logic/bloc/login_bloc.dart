import 'dart:async';

import 'package:faps_demonstrator_customer_app/logic/view_model/login_view_model.dart';

class LoginBloc {
  final loginController = StreamController<LoginViewModel>();

  Sink<LoginViewModel> get loginSink => loginController.sink;

  LoginBloc() {
    loginController.stream.listen(apiCall);
  }

  void apiCall(LoginViewModel userLogin) async {
    await userLogin.performLogin(userLogin);
    userLogin = null;
  }

  void dispose() {
    loginController.close();
  }
}