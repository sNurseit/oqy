
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:oqy/domain/dto/module_type.dart';
import 'package:oqy/domain/entity/profile.dart';
import 'package:oqy/features/admin/view/admin_screen.dart';
import 'package:oqy/features/auth/view/auth_screen.dart';
import 'package:oqy/features/auth/view/register_screen.dart';
import 'package:oqy/features/chat/view/chat_screen.dart';
import 'package:oqy/features/course/view/course_screen.dart';
import 'package:oqy/features/course_creating/view/course_creating_screen.dart';
import 'package:oqy/features/course_creating/view/material_edit_screen.dart';
import 'package:oqy/features/course_creating/view/module_screen.dart';
import 'package:oqy/features/course_creating/view/quiz_edit_screen.dart';
import 'package:oqy/features/course_learning/view/module_learn_screen.dart';
import 'package:oqy/features/course_learning/view/my_learning_screen.dart';
import 'package:oqy/features/course_learning/view/online_lesson_screen.dart';
import 'package:oqy/features/home/view/home_screen.dart';
import 'package:oqy/features/main/view/main_screen.dart';
import 'package:oqy/features/moderator/view/moderator_screen.dart';
import 'package:oqy/features/profile/view/profile_screen.dart';
import 'package:oqy/features/profile/view/settings_screen.dart';
import 'package:oqy/features/search/view/search_screen.dart';
import 'package:oqy/features/training/view/training_screen.dart';
import 'package:oqy/service/chat_service.dart';
import 'package:oqy/splash_screen.dart';
part 'router.gr.dart';


@AutoRouterConfig()
class AppRouter extends _$AppRouter{
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: SplashRoute.page,
      path: '/splash',
      initial: true,
    ),
    AutoRoute(
      page: AuthRoute.page,
      path: '/auth/',
    ),
    AutoRoute(
      page: RegisterRoute.page,
      path: '/register',
    ),
    AutoRoute(
      page: MainRoute.page,
      path: '/main/',
      children: [
        AutoRoute(
          page: HomeRoute.page,
          path: 'home',
          initial: true,

        ),
        AutoRoute(
          page: SearchRoute.page,
          path: 'search',
        ),
        AutoRoute(
          page: TrainingRoute.page,
          path: 'training',
        ),
        AutoRoute(
          page: ProfileRoute.page,
          path: 'profile',
        ),
      ],
    ),
    AutoRoute(
      page: CourseRoute.page,
      path: '/course',
    ),
    AutoRoute(
      page: ModuleRoute.page,
      path: '/module',
    ),
    AutoRoute(
      page: MaterialEditRoute.page,
      path: '/material-edit',
    ),
    AutoRoute(
      page: QuizEditRoute.page,
      path: '/quiz-edit',
    ),
    AutoRoute(
      page: ModuleLearnRoute.page,
      path: '/module-learn',
    ),
    AutoRoute(
      page: OnlineLessonRoute.page,
      path: '/online-lesson',
    ),
    AutoRoute(
      page: AdminRoute.page,
      path: '/admin',
    ),
    /*AutoRoute(
      page: ChatScreenRote.page,
      path: '/online-lesson',
    ),*/
    AutoRoute(
      page: CourseCreatingRoute.page,
      path: '/creating',
    ),
    AutoRoute(
      page: MyLearningRoute.page,
      path: '/learning',
    ),
    AutoRoute(
      page: SettingsRoute.page,
      path: '/settings',
    ),
  ];
}