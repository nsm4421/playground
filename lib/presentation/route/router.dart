import 'package:go_router/go_router.dart';

import '../view/diary/edit/edit_diary.page.dart';
import '../view/image_to_text/image_to_text.page.dart';

part 'paths.dart';

final routerConfig = GoRouter(
  initialLocation: Routes.editDiary.path,
  routes: [
    GoRoute(
        path: Routes.entry.path,
        builder: (context, state) => const ImageToTextPage()),
    GoRoute(
        path: Routes.editDiary.path,
        builder: (context, state) => const EditDiaryPage())
  ],
);
