import 'package:auto_route/auto_route.dart';
import 'package:flutter_nav_2/auto_route_demo/web/books/routes.dart';
import 'package:flutter_nav_2/auto_route_demo/web/settings/settings.dart';
import 'package:flutter_nav_2/auto_route_demo/web/unknown_page.dart';
import 'package:flutter_nav_2/auto_route_demo/web/users/routes.dart';

import '../dashboard_page.dart';

export 'web_router.gr.dart';

@CustomAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute<dynamic>>[
    AutoRoute<dynamic>(
      path: '/',
      page: DashboardPage,
      children: [
        // RedirectRoute(path: 'books', redirectTo: 'books'),
        booksRoute,
        usersRoute,
        AutoRoute<dynamic>(path: 'settings', page: SettingsPage),
      ],
    ),
    AutoRoute<dynamic>(path: '*', page: UnknownPage),
  ],
)
class $WebAppRouter {}
