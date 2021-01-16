import 'package:auto_route/auto_route.dart';
import 'package:flutter_nav_2/auto_route_demo/mobile/screens/user-data/sinlge_field_page.dart';
import 'package:flutter_nav_2/auto_route_demo/mobile/screens/user-data/user_data_page.dart';

import 'data_collector.dart';

const userDataRoutes = AutoRoute<dynamic>(
  path: '/user-data/:id',
  page: UserDataCollectorPage,
  children: [
    CustomRoute<dynamic>(
      page: SingleFieldPage,
      transitionsBuilder: TransitionsBuilders.slideRightWithFade,
    ),
    CustomRoute<dynamic>(
      page: UserDataPage,
      transitionsBuilder: TransitionsBuilders.slideRightWithFade,
    ),
  ],
);
