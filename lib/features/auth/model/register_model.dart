import 'package:flutter/material.dart';
import 'package:oqy/service/auth_service/auth_service.dart';


class RegisterModel extends ChangeNotifier{
  final loginTextController =TextEditingController();
  final passwordTextController = TextEditingController();
  String errorText = "";
  final _authService = AuthService();

  Future<void> login(BuildContext context) async{
    print('${loginTextController.text}${passwordTextController.text}');
    final status = await _authService.login(loginTextController.text, passwordTextController.text);
    if(status! >= 200 && status < 300){
      errorText ="Sucessfully logged in";
    }
    else if(status >= 400 && status < 500){
      errorText ="Login or password is incorrect";
    }
    else {
      errorText = "Problems in server, please try again after 5 minutes";
    }
    notifyListeners();
  }

}