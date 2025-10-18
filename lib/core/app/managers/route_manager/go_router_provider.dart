import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:hedef_takip_app/core/app/managers/route_manager/route_name.dart';
import 'package:hedef_takip_app/features/home/view/home_view.dart';
import 'package:hedef_takip_app/features/main_page/view/main_page_view.dart';
import 'package:hedef_takip_app/features/progress/view/progress_view.dart';

import 'package:riverpod/riverpod.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final _shellNavigatorKey = GlobalKey<NavigatorState>();

final goRouterProvider = GoRouter(
  initialLocation: RouteName.home,
  navigatorKey: _rootNavigatorKey,
  routes: [
    StatefulShellRoute.indexedStack(
      branches: [
        StatefulShellBranch(
          navigatorKey: _shellNavigatorKey,
          routes: [
            GoRoute(
              path: RouteName.home,
              builder: (context, state) => const HomeView(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: RouteName.progress,
              builder: (context, state) => const ProgressView(),
            ),
          ],
        ),
      ],
      builder: (context, state, navigationShell) {
        return MainPageView(navigationShell: navigationShell);
      },
    ),
  ],
);
