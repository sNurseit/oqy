

import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:oqy/features/auth/auth.dart';
import 'package:oqy/router/router.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 5), (){
      AutoRouter.of(context).replace(const AuthRoute());
    });


    return  Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 80.0),
          child: SizedBox(
            width: 400,
            height: 400,
            child: Lottie.asset(
              'assets/animations/splash.json',
              repeat: false,
            ),
          ),
        ),
      ),
    );
  }
}


