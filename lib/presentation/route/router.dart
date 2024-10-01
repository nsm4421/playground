import 'package:go_router/go_router.dart';

import '../view/image_to_text/image_to_text.page.dart';

part 'paths.dart';

final routerConfig = GoRouter(
  initialLocation: Routes.entry.path,
  routes: [
    GoRoute(
        path: Routes.entry.path,
        builder: (context, state) => const ImageToTextPage())
  ],
);
