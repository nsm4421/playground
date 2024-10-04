import 'package:go_router/go_router.dart';
import 'package:travel/presentation/view/auth/auth.page.dart';
import 'package:travel/presentation/view/main_view/index.page.dart';

import '../view/diary/edit/edit_diary.page.dart';

part 'paths.dart';

final routerConfig = GoRouter(
  initialLocation: Routes.auth.path,
  routes: [
    GoRoute(
        path: Routes.auth.path, builder: (context, state) => const AuthPage()),
    GoRoute(
        path: Routes.home.path, builder: (context, state) => const MainView()),
    GoRoute(
        path: Routes.editDiary.path,
        builder: (context, state) => const EditDiaryPage())
  ],
);
