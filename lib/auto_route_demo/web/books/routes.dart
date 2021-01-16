import 'package:auto_route/auto_route.dart';
import 'package:flutter_nav_2/auto_route_demo/web/books/book_details_page.dart';

import 'book_list_page.dart';

const booksRoute = AutoRoute<dynamic>(
  path: '',
  page: EmptyRouterPage,
  name: 'BooksRoute',
  children: [
    RedirectRoute(path: '', redirectTo: 'books'),
    AutoRoute<dynamic>(path: 'books', page: BookListPage),
    AutoRoute<dynamic>(
      path: 'books/:id',
      fullscreenDialog: false,
      page: BookDetailsPage,
    ),
  ],
);
