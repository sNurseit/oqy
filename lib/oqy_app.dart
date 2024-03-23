
import 'package:flutter/material.dart';
import 'package:oqy/router/router.dart';
import 'package:oqy/theme/DarkTheme.dart';
import 'package:oqy/theme/LightTheme.dart';

class OqyApp extends StatefulWidget {
  const OqyApp({super.key});

  @override
  State<OqyApp> createState() => _OqyAppState();
}

class _OqyAppState extends State<OqyApp> {
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return  MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: "Oqy",
      routerConfig: _appRouter.config(),
      theme: LightTheme.themeData,
      darkTheme: DarkTheme.themeData,
      themeMode: ThemeMode.system,
    );
  }
}


