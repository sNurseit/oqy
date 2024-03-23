import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/auth_model.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.read<AuthModel>();

    return SizedBox(
      width: double.infinity,
      child: FilledButton(
        onPressed:()=>model.login(context),
        style: Theme.of(context).filledButtonTheme.style,
        child:  const Padding(
          padding:  EdgeInsets.all(16.0),
          child:  Text(
            'Log In',
            style: TextStyle(
              fontSize: 18,

            ),
          ),
        ),
       
      ),
    );
  }
}