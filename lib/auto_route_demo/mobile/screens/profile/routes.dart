import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_nav_2/auto_route_demo/mobile/screens/profile/profile_page.dart';

import 'my_books_page.dart';

const profileTab = AutoRoute<dynamic>(
  path: 'profile',
  name: 'ProfileTab',
  page: EmptyRouterPage,
  children: [
    AutoRoute<dynamic>(path: '', page: ProfilePage),
    AutoRoute<dynamic>(path: 'books', page: MyBooksPage),
  ],
);
