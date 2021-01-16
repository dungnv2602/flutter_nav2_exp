// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i1;
import '../dashboard_page.dart' as _i2;
import '../unknown_page.dart' as _i3;
import '../users/routes.dart' as _i4;
import '../settings/settings.dart' as _i5;
import '../books/book_list_page.dart' as _i6;
import '../books/book_details_page.dart' as _i7;
import '../users/user_list_page.dart' as _i8;
import '../users/user_details_page.dart' as _i9;

class WebAppRouter extends _i1.RootStackRouter {
  WebAppRouter();

  @override
  final Map<String, _i1.PageFactory> pagesMap = {
    DashboardRoute.name: (entry) {
      return _i1.CustomPage(entry: entry, child: _i2.DashboardPage());
    },
    UnknownRoute.name: (entry) {
      return _i1.CustomPage(entry: entry, child: _i3.UnknownPage());
    },
    BooksRoute.name: (entry) {
      return _i1.CustomPage(entry: entry, child: const _i1.EmptyRouterPage());
    },
    UsersRoute.name: (entry) {
      return _i1.CustomPage(entry: entry, child: _i4.UsersRouterPage());
    },
    SettingsRoute.name: (entry) {
      return _i1.CustomPage(entry: entry, child: _i5.SettingsPage());
    },
    BookListRoute.name: (entry) {
      return _i1.CustomPage(entry: entry, child: _i6.BookListPage());
    },
    BookDetailsRoute.name: (entry) {
      var route = entry.routeData.as<BookDetailsRoute>();
      return _i1.CustomPage(
          entry: entry,
          child: _i7.BookDetailsPage(id: route.id),
          fullscreenDialog: false);
    },
    UserListRoute.name: (entry) {
      return _i1.CustomPage(entry: entry, child: _i8.UserListPage());
    },
    UserDetailsRoute.name: (entry) {
      var route = entry.routeData.as<UserDetailsRoute>();
      return _i1.CustomPage(
          entry: entry, child: _i9.UserDetailsPage(id: route.id));
    },
    UserBookDetails.name: (entry) {
      var route = entry.routeData.as<UserBookDetails>();
      return _i1.CustomPage(
          entry: entry, child: _i7.BookDetailsPage(id: route.id));
    }
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig<DashboardRoute>(DashboardRoute.name,
            path: '/',
            routeBuilder: (match) => DashboardRoute.fromMatch(match),
            children: [
              _i1.RouteConfig<BooksRoute>(BooksRoute.name,
                  path: '',
                  routeBuilder: (match) => BooksRoute.fromMatch(match),
                  children: [
                    _i1.RouteConfig('#redirect',
                        path: '', redirectTo: 'books', fullMatch: true),
                    _i1.RouteConfig<BookListRoute>(BookListRoute.name,
                        path: 'books',
                        routeBuilder: (match) =>
                            BookListRoute.fromMatch(match)),
                    _i1.RouteConfig<BookDetailsRoute>(BookDetailsRoute.name,
                        path: 'books/:id',
                        routeBuilder: (match) =>
                            BookDetailsRoute.fromMatch(match))
                  ]),
              _i1.RouteConfig<UsersRoute>(UsersRoute.name,
                  path: 'users',
                  routeBuilder: (match) => UsersRoute.fromMatch(match),
                  children: [
                    _i1.RouteConfig<UserListRoute>(UserListRoute.name,
                        path: '',
                        routeBuilder: (match) =>
                            UserListRoute.fromMatch(match)),
                    _i1.RouteConfig<UserDetailsRoute>(UserDetailsRoute.name,
                        path: ':id',
                        routeBuilder: (match) =>
                            UserDetailsRoute.fromMatch(match),
                        children: [
                          _i1.RouteConfig<UserBookDetails>(UserBookDetails.name,
                              path: 'book/:id',
                              routeBuilder: (match) =>
                                  UserBookDetails.fromMatch(match))
                        ])
                  ]),
              _i1.RouteConfig<SettingsRoute>(SettingsRoute.name,
                  path: 'settings',
                  routeBuilder: (match) => SettingsRoute.fromMatch(match))
            ]),
        _i1.RouteConfig<UnknownRoute>(UnknownRoute.name,
            path: '*', routeBuilder: (match) => UnknownRoute.fromMatch(match))
      ];
}

class DashboardRoute extends _i1.PageRouteInfo {
  const DashboardRoute({List<_i1.PageRouteInfo> children})
      : super(name, path: '/', initialChildren: children);

  DashboardRoute.fromMatch(_i1.RouteMatch match) : super.fromMatch(match);

  static const String name = 'DashboardRoute';
}

class UnknownRoute extends _i1.PageRouteInfo {
  const UnknownRoute() : super(name, path: '*');

  UnknownRoute.fromMatch(_i1.RouteMatch match) : super.fromMatch(match);

  static const String name = 'UnknownRoute';
}

class BooksRoute extends _i1.PageRouteInfo {
  const BooksRoute({List<_i1.PageRouteInfo> children})
      : super(name, path: '', initialChildren: children);

  BooksRoute.fromMatch(_i1.RouteMatch match) : super.fromMatch(match);

  static const String name = 'BooksRoute';
}

class UsersRoute extends _i1.PageRouteInfo {
  const UsersRoute({List<_i1.PageRouteInfo> children})
      : super(name, path: 'users', initialChildren: children);

  UsersRoute.fromMatch(_i1.RouteMatch match) : super.fromMatch(match);

  static const String name = 'UsersRoute';
}

class SettingsRoute extends _i1.PageRouteInfo {
  const SettingsRoute() : super(name, path: 'settings');

  SettingsRoute.fromMatch(_i1.RouteMatch match) : super.fromMatch(match);

  static const String name = 'SettingsRoute';
}

class BookListRoute extends _i1.PageRouteInfo {
  const BookListRoute() : super(name, path: 'books');

  BookListRoute.fromMatch(_i1.RouteMatch match) : super.fromMatch(match);

  static const String name = 'BookListRoute';
}

class BookDetailsRoute extends _i1.PageRouteInfo {
  BookDetailsRoute({this.id})
      : super(name, path: 'books/:id', params: {'id': id});

  BookDetailsRoute.fromMatch(_i1.RouteMatch match)
      : id = match.pathParams.getInt('id'),
        super.fromMatch(match);

  final int id;

  static const String name = 'BookDetailsRoute';
}

class UserListRoute extends _i1.PageRouteInfo {
  const UserListRoute() : super(name, path: '');

  UserListRoute.fromMatch(_i1.RouteMatch match) : super.fromMatch(match);

  static const String name = 'UserListRoute';
}

class UserDetailsRoute extends _i1.PageRouteInfo {
  UserDetailsRoute({this.id, List<_i1.PageRouteInfo> children})
      : super(name, path: ':id', params: {'id': id}, initialChildren: children);

  UserDetailsRoute.fromMatch(_i1.RouteMatch match)
      : id = match.pathParams.getInt('id'),
        super.fromMatch(match);

  final int id;

  static const String name = 'UserDetailsRoute';
}

class UserBookDetails extends _i1.PageRouteInfo {
  UserBookDetails({this.id})
      : super(name, path: 'book/:id', params: {'id': id});

  UserBookDetails.fromMatch(_i1.RouteMatch match)
      : id = match.pathParams.getInt('id'),
        super.fromMatch(match);

  final int id;

  static const String name = 'UserBookDetails';
}
