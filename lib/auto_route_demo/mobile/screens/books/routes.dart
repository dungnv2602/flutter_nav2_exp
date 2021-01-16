import 'package:auto_route/auto_route.dart';

import 'book_details_page.dart';
import 'book_list_page.dart';

const booksTab = AutoRoute<dynamic>(
  path: '',
  page: EmptyRouterPage,
  name: 'BooksTab',
  children: [
    RedirectRoute(path: '', redirectTo: 'books'),
    AutoRoute<dynamic>(path: 'books', page: BookListPage),
    AutoRoute<dynamic>(
      path: 'books/:id',
      page: BookDetailsPage,
      // guards: [AuthGuard],
    ),
  ],
);
