
import 'package:flutter/material.dart';
import 'package:oqy/features/auth/model/auth_model.dart';
import 'package:oqy/features/auth/widgets/error_text.dart';
import 'package:oqy/features/auth/widgets/input_login.dart';
import 'package:oqy/features/auth/widgets/input_password.dart';
import 'package:oqy/features/auth/widgets/login_button.dart';
import 'package:oqy/features/auth/widgets/redirect_register.dart';
import 'package:provider/provider.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:Center(
          child: _FormWidget.create()
      )
    );
  }
}

class _FormWidget extends StatelessWidget {
  const _FormWidget({super.key});

  static Widget create(){
    return ChangeNotifierProvider(
        create: (_)=>AuthModel(),
        child: const _FormWidget(),
    );
  }

  @override
  Widget build(BuildContext context) {
    
    return  Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
             Text(
               "Sign in",
               style: Theme.of(context).textTheme.titleLarge,
             ),
            const SizedBox(height: 25.0,),
            const InputLogin(),
            const SizedBox(height: 25.0,),
            const InputPassword(),
            const SizedBox(height: 20.0,),
            const RedirectRegister(),
            const SizedBox(height: 25.0,),
            const LoginButton(),
          ],
        ),
    );
  }
}













