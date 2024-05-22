
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:oqy/features/profile/bloc/profile_bloc.dart';
import 'package:oqy/router/router.dart';
import 'package:oqy/service/profile_service.dart';
import 'package:oqy/theme/DarkTheme.dart';
import 'package:oqy/theme/LightTheme.dart';
import 'package:provider/provider.dart';
import 'package:oqy/generated/l10n.dart';
import 'package:oqy/domain/provider/locale_provider.dart';

class OqyApp extends StatefulWidget {
  const OqyApp({super.key});

  @override
  State<OqyApp> createState() => _OqyAppState();
}

class _OqyAppState extends State<OqyApp> {
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ProfileBloc>(create: (_) => ProfileBloc(GetIt.I<ProfileService>())),
        ChangeNotifierProvider<LocaleProvider>(create: (_) => LocaleProvider()),
      ],
      child: Consumer<LocaleProvider>(
        builder: (context, localeProvider, child) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            locale: localeProvider.locale,
            title: "Oqy",
            routerConfig: _appRouter.config(),
            theme: LightTheme.themeData,
            darkTheme: DarkTheme.themeData,
            themeMode: ThemeMode.system,
          );
        },
      ),
    );
  }
}
