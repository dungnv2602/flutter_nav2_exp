import 'package:auto_route/auto_route.dart';
import 'package:flutter_nav_2/auto_route_demo/mobile/screens/books/routes.dart';
import 'package:flutter_nav_2/auto_route_demo/mobile/screens/home_page.dart';
import 'package:flutter_nav_2/auto_route_demo/mobile/screens/login_page.dart';
import 'package:flutter_nav_2/auto_route_demo/mobile/screens/profile/routes.dart';
import 'package:flutter_nav_2/auto_route_demo/mobile/screens/settings.dart';
import 'package:flutter_nav_2/auto_route_demo/mobile/screens/user-data/routes.dart';

export 'router.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute<dynamic>>[
    AutoRoute<dynamic>(
      path: '/',
      page: HomePage,
      // guards: [AuthGuard],
      usesTabsRouter: true,
      children: [
        booksTab,
        profileTab,
        AutoRoute<dynamic>(
          path: 'settings',
          page: SettingsPage,
          name: 'SettingsTab',
        ),
      ],
    ),
    userDataRoutes,
    AutoRoute<dynamic>(
        path: '/login', page: LoginPage, fullscreenDialog: false),
    RedirectRoute(path: '*', redirectTo: '/'),
  ],
)
class $AppRouter {}
