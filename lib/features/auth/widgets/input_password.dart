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
          borderSide: const BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(6.0),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 17,vertical: 20),
        labelText: "Password",
        labelStyle: const TextStyle(
          color:  Color.fromRGBO(64, 58, 75, 60)
        ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).primaryColor), // Цвет рамки при активном состоянии
            borderRadius: BorderRadius.circular(6.0),
          ),
      ),
    );
  }
}