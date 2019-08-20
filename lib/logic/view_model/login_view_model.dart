import 'dart:async';

class LoginViewModel {
  String username;
  String passEncoded;
  bool result = false;

  Future<Null> performLogin(LoginViewModel userLogin) async {
    this.result = true;
  }
}