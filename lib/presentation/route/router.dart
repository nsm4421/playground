import 'package:go_router/go_router.dart';
import 'package:travel/presentation/view/index.page.dart';

part 'paths.dart';

final routerConfig = GoRouter(
  initialLocation: Routes.entry.path,
  routes: [
    GoRoute(
        path: Routes.entry.path, builder: (context, state) => const IndexPage())
  ],
);
