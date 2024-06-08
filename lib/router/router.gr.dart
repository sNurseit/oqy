// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    AdminRoute.name: (routeData) {
      final args = routeData.argsAs<AdminRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: AdminScreen(
          profile: args.profile,
          key: args.key,
        ),
      );
    },
    AuthRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AuthScreen(),
      );
    },
    ChatRoute.name: (routeData) {
      final args = routeData.argsAs<ChatRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ChatScreen(
          key: args.key,
          profile: args.profile,
        ),
      );
    },
    CourseCreatingRoute.name: (routeData) {
      final args = routeData.argsAs<CourseCreatingRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CourseCreatingScreen(
          key: args.key,
          courseId: args.courseId,
        ),
      );
    },
    CourseRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<CourseRouteArgs>(
          orElse: () =>
              CourseRouteArgs(courseId: pathParams.getInt('courseId')));
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CourseScreen(
          key: args.key,
          courseId: args.courseId,
        ),
      );
    },
    HomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HomeScreen(),
      );
    },
    MainRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const MainScreen(),
      );
    },
    MaterialEditRoute.name: (routeData) {
      final args = routeData.argsAs<MaterialEditRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: MaterialEditScreen(
          key: args.key,
          materialStep: args.materialStep,
          moduleStep: args.moduleStep,
        ),
      );
    },
    ModeratorRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ModeratorScreen(),
      );
    },
    ModuleLearnRoute.name: (routeData) {
      final args = routeData.argsAs<ModuleLearnRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ModuleLearnScreen(
          module: args.module,
          materialIndex: args.materialIndex,
          key: args.key,
        ),
      );
    },
    ModuleRoute.name: (routeData) {
      final args = routeData.argsAs<ModuleRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ModuleScreen(
          key: args.key,
          moduleId: args.moduleId,
        ),
      );
    },
    MyLearningRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<MyLearningRouteArgs>(
          orElse: () =>
              MyLearningRouteArgs(courseId: pathParams.getInt('courseId')));
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: MyLearningScreen(
          key: args.key,
          courseId: args.courseId,
        ),
      );
    },
    OnlineLessonRoute.name: (routeData) {
      final args = routeData.argsAs<OnlineLessonRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: OnlineLessonScreen(
          courseId: args.courseId,
          roomId: args.roomId,
          key: args.key,
        ),
      );
    },
    ProfileRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ProfileScreen(),
      );
    },
    QuizEditRoute.name: (routeData) {
      final args = routeData.argsAs<QuizEditRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: QuizEditScreen(
          id: args.id,
          courseId: args.courseId,
          key: args.key,
        ),
      );
    },
    RegisterRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const RegisterScreen(),
      );
    },
    SearchRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SearchScreen(),
      );
    },
    SettingsRoute.name: (routeData) {
      final args = routeData.argsAs<SettingsRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: SettingsScreen(
          key: args.key,
          profile: args.profile,
        ),
      );
    },
    SplashRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SplashScreen(),
      );
    },
    TrainingRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const TrainingScreen(),
      );
    },
  };
}

/// generated route for
/// [AdminScreen]
class AdminRoute extends PageRouteInfo<AdminRouteArgs> {
  AdminRoute({
    required Profile profile,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          AdminRoute.name,
          args: AdminRouteArgs(
            profile: profile,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'AdminRoute';

  static const PageInfo<AdminRouteArgs> page = PageInfo<AdminRouteArgs>(name);
}

class AdminRouteArgs {
  const AdminRouteArgs({
    required this.profile,
    this.key,
  });

  final Profile profile;

  final Key? key;

  @override
  String toString() {
    return 'AdminRouteArgs{profile: $profile, key: $key}';
  }
}

/// generated route for
/// [AuthScreen]
class AuthRoute extends PageRouteInfo<void> {
  const AuthRoute({List<PageRouteInfo>? children})
      : super(
          AuthRoute.name,
          initialChildren: children,
        );

  static const String name = 'AuthRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ChatScreen]
class ChatRoute extends PageRouteInfo<ChatRouteArgs> {
  ChatRoute({
    Key? key,
    required Profile profile,
    List<PageRouteInfo>? children,
  }) : super(
          ChatRoute.name,
          args: ChatRouteArgs(
            key: key,
            profile: profile,
          ),
          initialChildren: children,
        );

  static const String name = 'ChatRoute';

  static const PageInfo<ChatRouteArgs> page = PageInfo<ChatRouteArgs>(name);
}

class ChatRouteArgs {
  const ChatRouteArgs({
    this.key,
    required this.profile,
  });

  final Key? key;

  final Profile profile;

  @override
  String toString() {
    return 'ChatRouteArgs{key: $key, profile: $profile}';
  }
}

/// generated route for
/// [CourseCreatingScreen]
class CourseCreatingRoute extends PageRouteInfo<CourseCreatingRouteArgs> {
  CourseCreatingRoute({
    Key? key,
    required int courseId,
    List<PageRouteInfo>? children,
  }) : super(
          CourseCreatingRoute.name,
          args: CourseCreatingRouteArgs(
            key: key,
            courseId: courseId,
          ),
          initialChildren: children,
        );

  static const String name = 'CourseCreatingRoute';

  static const PageInfo<CourseCreatingRouteArgs> page =
      PageInfo<CourseCreatingRouteArgs>(name);
}

class CourseCreatingRouteArgs {
  const CourseCreatingRouteArgs({
    this.key,
    required this.courseId,
  });

  final Key? key;

  final int courseId;

  @override
  String toString() {
    return 'CourseCreatingRouteArgs{key: $key, courseId: $courseId}';
  }
}

/// generated route for
/// [CourseScreen]
class CourseRoute extends PageRouteInfo<CourseRouteArgs> {
  CourseRoute({
    Key? key,
    required int courseId,
    List<PageRouteInfo>? children,
  }) : super(
          CourseRoute.name,
          args: CourseRouteArgs(
            key: key,
            courseId: courseId,
          ),
          rawPathParams: {'courseId': courseId},
          initialChildren: children,
        );

  static const String name = 'CourseRoute';

  static const PageInfo<CourseRouteArgs> page = PageInfo<CourseRouteArgs>(name);
}

class CourseRouteArgs {
  const CourseRouteArgs({
    this.key,
    required this.courseId,
  });

  final Key? key;

  final int courseId;

  @override
  String toString() {
    return 'CourseRouteArgs{key: $key, courseId: $courseId}';
  }
}

/// generated route for
/// [HomeScreen]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [MainScreen]
class MainRoute extends PageRouteInfo<void> {
  const MainRoute({List<PageRouteInfo>? children})
      : super(
          MainRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [MaterialEditScreen]
class MaterialEditRoute extends PageRouteInfo<MaterialEditRouteArgs> {
  MaterialEditRoute({
    Key? key,
    required int materialStep,
    required int moduleStep,
    List<PageRouteInfo>? children,
  }) : super(
          MaterialEditRoute.name,
          args: MaterialEditRouteArgs(
            key: key,
            materialStep: materialStep,
            moduleStep: moduleStep,
          ),
          initialChildren: children,
        );

  static const String name = 'MaterialEditRoute';

  static const PageInfo<MaterialEditRouteArgs> page =
      PageInfo<MaterialEditRouteArgs>(name);
}

class MaterialEditRouteArgs {
  const MaterialEditRouteArgs({
    this.key,
    required this.materialStep,
    required this.moduleStep,
  });

  final Key? key;

  final int materialStep;

  final int moduleStep;

  @override
  String toString() {
    return 'MaterialEditRouteArgs{key: $key, materialStep: $materialStep, moduleStep: $moduleStep}';
  }
}

/// generated route for
/// [ModeratorScreen]
class ModeratorRoute extends PageRouteInfo<void> {
  const ModeratorRoute({List<PageRouteInfo>? children})
      : super(
          ModeratorRoute.name,
          initialChildren: children,
        );

  static const String name = 'ModeratorRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ModuleLearnScreen]
class ModuleLearnRoute extends PageRouteInfo<ModuleLearnRouteArgs> {
  ModuleLearnRoute({
    required StepItem module,
    required int materialIndex,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          ModuleLearnRoute.name,
          args: ModuleLearnRouteArgs(
            module: module,
            materialIndex: materialIndex,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'ModuleLearnRoute';

  static const PageInfo<ModuleLearnRouteArgs> page =
      PageInfo<ModuleLearnRouteArgs>(name);
}

class ModuleLearnRouteArgs {
  const ModuleLearnRouteArgs({
    required this.module,
    required this.materialIndex,
    this.key,
  });

  final StepItem module;

  final int materialIndex;

  final Key? key;

  @override
  String toString() {
    return 'ModuleLearnRouteArgs{module: $module, materialIndex: $materialIndex, key: $key}';
  }
}

/// generated route for
/// [ModuleScreen]
class ModuleRoute extends PageRouteInfo<ModuleRouteArgs> {
  ModuleRoute({
    Key? key,
    required int moduleId,
    List<PageRouteInfo>? children,
  }) : super(
          ModuleRoute.name,
          args: ModuleRouteArgs(
            key: key,
            moduleId: moduleId,
          ),
          initialChildren: children,
        );

  static const String name = 'ModuleRoute';

  static const PageInfo<ModuleRouteArgs> page = PageInfo<ModuleRouteArgs>(name);
}

class ModuleRouteArgs {
  const ModuleRouteArgs({
    this.key,
    required this.moduleId,
  });

  final Key? key;

  final int moduleId;

  @override
  String toString() {
    return 'ModuleRouteArgs{key: $key, moduleId: $moduleId}';
  }
}

/// generated route for
/// [MyLearningScreen]
class MyLearningRoute extends PageRouteInfo<MyLearningRouteArgs> {
  MyLearningRoute({
    Key? key,
    required int courseId,
    List<PageRouteInfo>? children,
  }) : super(
          MyLearningRoute.name,
          args: MyLearningRouteArgs(
            key: key,
            courseId: courseId,
          ),
          rawPathParams: {'courseId': courseId},
          initialChildren: children,
        );

  static const String name = 'MyLearningRoute';

  static const PageInfo<MyLearningRouteArgs> page =
      PageInfo<MyLearningRouteArgs>(name);
}

class MyLearningRouteArgs {
  const MyLearningRouteArgs({
    this.key,
    required this.courseId,
  });

  final Key? key;

  final int courseId;

  @override
  String toString() {
    return 'MyLearningRouteArgs{key: $key, courseId: $courseId}';
  }
}

/// generated route for
/// [OnlineLessonScreen]
class OnlineLessonRoute extends PageRouteInfo<OnlineLessonRouteArgs> {
  OnlineLessonRoute({
    required int courseId,
    required int roomId,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          OnlineLessonRoute.name,
          args: OnlineLessonRouteArgs(
            courseId: courseId,
            roomId: roomId,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'OnlineLessonRoute';

  static const PageInfo<OnlineLessonRouteArgs> page =
      PageInfo<OnlineLessonRouteArgs>(name);
}

class OnlineLessonRouteArgs {
  const OnlineLessonRouteArgs({
    required this.courseId,
    required this.roomId,
    this.key,
  });

  final int courseId;

  final int roomId;

  final Key? key;

  @override
  String toString() {
    return 'OnlineLessonRouteArgs{courseId: $courseId, roomId: $roomId, key: $key}';
  }
}

/// generated route for
/// [ProfileScreen]
class ProfileRoute extends PageRouteInfo<void> {
  const ProfileRoute({List<PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [QuizEditScreen]
class QuizEditRoute extends PageRouteInfo<QuizEditRouteArgs> {
  QuizEditRoute({
    required int id,
    required int courseId,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          QuizEditRoute.name,
          args: QuizEditRouteArgs(
            id: id,
            courseId: courseId,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'QuizEditRoute';

  static const PageInfo<QuizEditRouteArgs> page =
      PageInfo<QuizEditRouteArgs>(name);
}

class QuizEditRouteArgs {
  const QuizEditRouteArgs({
    required this.id,
    required this.courseId,
    this.key,
  });

  final int id;

  final int courseId;

  final Key? key;

  @override
  String toString() {
    return 'QuizEditRouteArgs{id: $id, courseId: $courseId, key: $key}';
  }
}

/// generated route for
/// [RegisterScreen]
class RegisterRoute extends PageRouteInfo<void> {
  const RegisterRoute({List<PageRouteInfo>? children})
      : super(
          RegisterRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegisterRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SearchScreen]
class SearchRoute extends PageRouteInfo<void> {
  const SearchRoute({List<PageRouteInfo>? children})
      : super(
          SearchRoute.name,
          initialChildren: children,
        );

  static const String name = 'SearchRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SettingsScreen]
class SettingsRoute extends PageRouteInfo<SettingsRouteArgs> {
  SettingsRoute({
    Key? key,
    required Profile? profile,
    List<PageRouteInfo>? children,
  }) : super(
          SettingsRoute.name,
          args: SettingsRouteArgs(
            key: key,
            profile: profile,
          ),
          initialChildren: children,
        );

  static const String name = 'SettingsRoute';

  static const PageInfo<SettingsRouteArgs> page =
      PageInfo<SettingsRouteArgs>(name);
}

class SettingsRouteArgs {
  const SettingsRouteArgs({
    this.key,
    required this.profile,
  });

  final Key? key;

  final Profile? profile;

  @override
  String toString() {
    return 'SettingsRouteArgs{key: $key, profile: $profile}';
  }
}

/// generated route for
/// [SplashScreen]
class SplashRoute extends PageRouteInfo<void> {
  const SplashRoute({List<PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [TrainingScreen]
class TrainingRoute extends PageRouteInfo<void> {
  const TrainingRoute({List<PageRouteInfo>? children})
      : super(
          TrainingRoute.name,
          initialChildren: children,
        );

  static const String name = 'TrainingRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
