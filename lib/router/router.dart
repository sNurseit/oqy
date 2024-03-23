
import 'package:auto_route/auto_route.dart';
import 'package:oqy/features/auth/view/auth_screen.dart';
import 'package:oqy/features/auth/view/register_screen.dart';
import 'package:oqy/features/home/view/home_screen.dart';
import 'package:oqy/features/main/view/main_screen.dart';
import 'package:oqy/features/profile/view/profile_screen.dart';
import 'package:oqy/features/search/view/search_screen.dart';
import 'package:oqy/features/training/view/training_screen.dart';
part 'router.gr.dart';


@AutoRouterConfig()
class AppRouter extends _$AppRouter{
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: AuthRoute.page,
      path: '/auth',
      initial: true,
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
      ]
    ),
  ];
}