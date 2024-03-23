import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/auth_model.dart';

class RedirectRegister extends StatelessWidget {
  const RedirectRegister({super.key});

  @override
  Widget build(BuildContext context) {
    
    final model = context.read<AuthModel>();

    return   SizedBox(
      width: double.infinity,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
             Text(
              "If you don't have an account",
              style: Theme.of(context).textTheme.bodySmall
            ),
            GestureDetector(
              onTap: ()=>model.redirectToRegister(context),
              child:  Text(
                "Register",
                style: Theme.of(context).textTheme.labelSmall
              ),
            ),
          ]
      ),
    );
  }
}