import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:oqy/router/router.dart';
import 'package:oqy/service/auth_service/auth_service.dart';


class AuthModel extends ChangeNotifier{
  final loginTextController =TextEditingController();
  final passwordTextController = TextEditingController();
  String errorText = "";
  final _authService = AuthService();

  Future<void> login(BuildContext context) async {
    final login= loginTextController.text;
    final password = passwordTextController.text;

    if (login.isEmpty || password.isEmpty){
      errorText = 'Enter login or password';
      notifyListeners();
      return;
    }
     await _authService.login(login, password)
      .then((status) {
        if (status! >= 200 && status < 300) {
          errorText = "Successfully logged in";
          AutoRouter.of(context).push(const MainRoute());
        } 
        else if (status >= 400 && status < 500) {
          errorText = "Login or password is incorrect";
        } 
        else {
          errorText = "Problems in server, please try again after 5 minutes";
        }
      });
      notifyListeners();

  }


  void redirectToRegister(BuildContext context){
    AutoRouter.of(context).push(const RegisterRoute());
  }

}