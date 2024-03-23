import 'package:auto_route/auto_route.dart';
import  'package:flutter/material.dart';
import 'package:oqy/features/auth/widgets/error_text.dart';
import 'package:provider/provider.dart';

import '../model/register_model.dart';

@RoutePage() 
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
        create: (_)=>RegisterModel(), 
        child: const _FormWidget(),
    );
  }

  @override
  Widget build(BuildContext context) {

    return const Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            Text(
               "Sign up",
               style: TextStyle(
                 fontSize: 40,
                 fontWeight: FontWeight.w600,
               ),
            ),
            ErrorText(),
            SizedBox(height: 10,),
            
              
          ],
        ),
    );
  }
}