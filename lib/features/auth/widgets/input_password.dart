import 'package:flutter/material.dart';
import '../model/auth_model.dart';
import 'package:provider/provider.dart';

class InputPassword extends StatelessWidget {
  const InputPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.read<AuthModel>();

    return  TextField(
      obscureText: true,
      controller: model.passwordTextController,
      style: Theme.of(context).textTheme.displayLarge,
      decoration: InputDecoration(
        filled: false,
            border:  OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).focusColor),
              borderRadius: BorderRadius.circular(6.0),
            ),
            labelText: "Password",
            contentPadding: const EdgeInsets.symmetric(horizontal: 17,vertical: 20),
            labelStyle:  TextStyle(
              color:  Theme.of(context).hintColor,
            ), 
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).primaryColor),
            borderRadius: BorderRadius.circular(6.0),
          ),
      ),
    );
  }
}