
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:oqy/features/course_creating/bloc/module_edit_bloc/module_edit_bloc.dart';
import 'package:oqy/features/profile/bloc/profile_bloc.dart';
import 'package:oqy/router/router.dart';
import 'package:oqy/service/course_category_service.dart';
import 'package:oqy/service/course_service_impl.dart';
import 'package:oqy/service/material_service.dart';
import 'package:oqy/service/module_service.dart';
import 'package:oqy/service/profile_service.dart';
import 'package:oqy/theme/DarkTheme.dart';
import 'package:oqy/theme/LightTheme.dart';
import 'package:provider/provider.dart';
import 'package:oqy/generated/l10n.dart';
import 'package:oqy/domain/provider/locale_provider.dart';
import 'package:oqy/features/course_creating/bloc/course_creating_bloc/course_creating_bloc.dart';

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
        Provider<CourseCreatingBloc>(create: (_) =>  
          CourseCreatingBloc(courseService: GetIt.I<CourseService>(), 
          courseCategoryService: GetIt.I<CourseCategoryService>(),
          moduleService: GetIt.I<ModuleService>()
          ),
        ),
        Provider<ModuleEditBloc>(create: (_)=> ModuleEditBloc(
          moduleService: GetIt.I<ModuleService>(),
          materialService: GetIt.I<MaterialService>()),
        ),
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
