import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:oqy/domain/dto/confirmation_dto.dart';
import 'package:oqy/domain/entity/register.dart';
import 'package:oqy/service/impl/auth_service_impl.dart';


class RegisterModel extends ChangeNotifier {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final firstnameTextController = TextEditingController();
  final lastnameTextController = TextEditingController();
  final dateOfBirthTextController = TextEditingController();
  final codeTextController = TextEditingController();
  late ConfirmationDto? confirmationDto;

  String errorText = "";
  final _authService = GetIt.I<AuthService>();
  bool isLoading = false;
  bool openBottomSheet =false;
  bool registered = false;
  Future<void> register() async {
    isLoading = true;
    notifyListeners();

    final registerEntity = Register(
      firstname: firstnameTextController.text, 
      lastname: lastnameTextController.text,
      email: emailTextController.text,
      password: passwordTextController.text,
      dateOfBirth: dateOfBirthTextController.text.isEmpty? null: DateTime.parse(dateOfBirthTextController.text),
    );
    if(firstnameTextController.text.isNotEmpty
     && lastnameTextController.text.isNotEmpty 
     && emailTextController.text.isNotEmpty
     && passwordTextController.text.isNotEmpty) {
      confirmationDto = (await _authService.register(registerEntity));
    }
    isLoading = false;
    if (confirmationDto!=null) {
      openBottomSheet =true;
      notifyListeners();
    }
    notifyListeners();
  }

  void setDateOfBirth(DateTime date) {
    dateOfBirthTextController.text = date.toIso8601String();
  }

  Future<void> verifyConfirmationCode(BuildContext context) async {
    
      final response = await _authService.checkVerificationCode(confirmationDto!, codeTextController.text);
      if(response != null){
        registered=true;
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      }
    
  } 
}
