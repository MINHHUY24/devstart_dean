import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../modules/achievement/bindings/achievement_binding.dart';
import '../modules/achievement/views/achievement_view.dart';
import '../modules/courses/bindings/courses_binding.dart';
import '../modules/courses/views/courses_view.dart';
import '../modules/courses_detail/bindings/courses_detail_binding.dart';
import '../modules/courses_detail/views/courses_detail_view.dart';
import '../modules/history/bindings/history_binding.dart';
import '../modules/history/views/history_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/language/bindings/language_binding.dart';
import '../modules/language/views/language_view.dart';
import '../modules/level/bindings/level_binding.dart';
import '../modules/level/views/level_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/mobile_layout/bindings/mobile_layout_binding.dart';
import '../modules/mobile_layout/views/mobile_layout_view.dart';
import '../modules/notification/bindings/notification_binding.dart';
import '../modules/notification/views/notification_view.dart';
import '../modules/playGame/bindings/play_game_binding.dart';
import '../modules/playGame/views/play_game_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static final INITIAL =
      Supabase.instance.client.auth.currentSession?.user != null
          ? Routes.MOBILE_LAYOUT
          : Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.COURSES,
      page: () => const CoursesView(),
      binding: CoursesBinding(),
    ),
    GetPage(
      name: _Paths.MOBILE_LAYOUT,
      page: () => const MobileLayoutView(),
      binding: MobileLayoutBinding(),
    ),
    GetPage(
      name: _Paths.COURSES_DETAIL,
      page: () => CoursesDetailView(),
      binding: CoursesDetailBinding(),
    ),
    GetPage(
      name: _Paths.HISTORY,
      page: () => HistoryView(),
      binding: HistoryBinding(),
      // transition: Transition.cupertino,
    ),

    GetPage(
      name: _Paths.NOTIFICATION,
      page: () => const NotificationView(),
      binding: NotificationBinding(),
    ),
    GetPage(
      name: _Paths.ACHIEVEMENT,
      page: () => const AchievementView(),
      binding: AchievementBinding(),
    ),
    GetPage(
      name: _Paths.LANGUAGE,
      page: () => const LanguageView(),
      binding: LanguageBinding(),
    ),
    GetPage(
      name: _Paths.LEVEL,
      page: () => LevelView(),
      binding: LevelBinding(),
    ),
    GetPage(
      name: _Paths.PLAY_GAME,
      page: () => PlayGameView(),
      binding: PlayGameBinding(),
    ),
  ];
}
