import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_nav_2/auto_route_demo/data/db.dart';
import 'package:flutter_nav_2/auto_route_demo/web/books/book_details_page.dart';
import 'package:flutter_nav_2/auto_route_demo/web/users/user_details_page.dart';
import 'package:flutter_nav_2/auto_route_demo/web/users/user_list_page.dart';
import 'package:provider/provider.dart';

const usersRoute = AutoRoute<dynamic>(
  path: 'users',
  page: UsersRouterPage,
  name: 'UsersRoute',
  children: [
    AutoRoute<dynamic>(path: '', page: UserListPage),
    AutoRoute<dynamic>(
      path: ':id',
      page: UserDetailsPage,
      children: [
        AutoRoute<dynamic>(
          name: 'UserBookDetails',
          path: 'book/:id',
          page: BookDetailsPage,
        )
      ],
    ),
  ],
);

class UsersRouterPage extends AutoRouter implements AutoRouteWrapper {
  @override
  Widget wrappedRoute(BuildContext context) {
    return Provider<UsersDB>(
      create: (_) => UsersDB(),
      child: this,
    );
  }
}
