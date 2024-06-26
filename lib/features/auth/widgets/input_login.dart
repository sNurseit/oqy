import 'package:flutter/material.dart';
import '../model/auth_model.dart';
import 'package:provider/provider.dart';

class InputLogin extends StatelessWidget {
  const InputLogin({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final model = context.read<AuthModel>();
    return  TextField(
      cursorColor: theme.primaryColor,
      style: theme.textTheme.displayLarge,
      controller: model.loginTextController,
      decoration: InputDecoration(
      filled: false,
        border:  OutlineInputBorder(
          borderSide: BorderSide(color: theme.focusColor),
          borderRadius: BorderRadius.circular(6.0),
        ),
        labelText: "Email",
        contentPadding: const EdgeInsets.symmetric(horizontal: 17,vertical: 20),
        labelStyle: TextStyle(
          color: theme.hintColor,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: theme.primaryColor),
          borderRadius: BorderRadius.circular(6.0),
        ),
      ),
    );
  }
}