// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';

// /// null-safety review
// /// "!" must be abused because compiler does not regnognise a variable is already non-null in scenarios that I already have a conditional check before hand
// ///

// void main() {
//   runApp(BooksApp());
// }

// class BooksApp extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() => _BooksAppState();
// }

// class _BooksAppState extends State<BooksApp> {
//   BookRouterDelegate _routerDelegate = BookRouterDelegate();
//   BookRouteInformationParser _routeInformationParser =
//       BookRouteInformationParser();

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp.router(
//       title: 'Books App',
//       routerDelegate: _routerDelegate,
//       routeInformationParser: _routeInformationParser,
//     );
//   }
// }

// class BookRoutePath {
//   final int? id;
//   final bool isUnknown;

//   BookRoutePath.unknown()
//       : id = null,
//         isUnknown = true;
//   BookRoutePath.home()
//       : id = null,
//         isUnknown = false;

//   BookRoutePath.details(this.id) : isUnknown = false;

//   bool get isHomePage => id == null;

//   bool get isDetailsPage => id != null;

//   @override
//   String toString() {
//     return 'BookRoutePath: id:$id - isUnknown:$isUnknown';
//   }
// }

// class BookRouteInformationParser extends RouteInformationParser<BookRoutePath> {
//   @override
//   Future<BookRoutePath> parseRouteInformation(
//       RouteInformation routeInformation) async {
//     debugPrint('parseRouteInformation: ${routeInformation.toString()}');

//     final uri = Uri.parse(routeInformation.location ?? '/');
//     // Handle '/'
//     if (uri.pathSegments.length == 0) {
//       return BookRoutePath.home();
//     }
//     // Handle '/book/:id'
//     if (uri.pathSegments.length == 2) {
//       if (uri.pathSegments[0] != 'book') return BookRoutePath.unknown();
//       var remaining = uri.pathSegments[1];
//       var id = int.tryParse(remaining);
//       if (id == null) return BookRoutePath.unknown();
//       return BookRoutePath.details(id);
//     }
//     // Handle unknown routes
//     return BookRoutePath.unknown();
//   }

//   @override
//   RouteInformation restoreRouteInformation(BookRoutePath path) {
//     debugPrint('restoreRouteInformation: ${path.toString()}');

//     if (path.isUnknown) {
//       return RouteInformation(location: '/404');
//     }
//     if (path.isHomePage) {
//       return RouteInformation(location: '/');
//     }
//     if (path.isDetailsPage) {
//       return RouteInformation(location: '/book/${path.id}');
//     }

//     return RouteInformation(location: '/');
//   }
// }

// class BookRouterDelegate extends RouterDelegate<BookRoutePath>
//     with ChangeNotifier, PopNavigatorRouterDelegateMixin<BookRoutePath> {
//   BookRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>();

//   final GlobalKey<NavigatorState> navigatorKey;

//   Book? _selectedBook;
//   bool show404 = false;

//   List<Book> books = [
//     Book('Stranger in a Strange Land', 'Robert A. Heinlein'),
//     Book('Foundation', 'Isaac Asimov'),
//     Book('Fahrenheit 451', 'Ray Bradbury'),
//   ];

//   BookRoutePath get currentConfiguration {
//     if (show404) {
//       return BookRoutePath.unknown();
//     }
//     return _selectedBook == null
//         ? BookRoutePath.home()
//         : BookRoutePath.details(books.indexOf(_selectedBook!));
//   }

//   @override
//   Future<void> setNewRoutePath(BookRoutePath path) async {
//     debugPrint('setNewRoutePath: ${path.toString()}');

//     if (path.isUnknown) {
//       _selectedBook = null;
//       show404 = true;
//       return;
//     }

//     if (path.isDetailsPage) {
//       if (path.id! < 0 || path.id! > books.length - 1) {
//         show404 = true;
//         return;
//       }

//       _selectedBook = books[path.id!];
//     } else {
//       _selectedBook = null;
//     }

//     show404 = false;
//   }

//   void _handleBookTapped(Book book) {
//     _selectedBook = book;
//     notifyListeners();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Navigator(
//       key: navigatorKey,
//       pages: [
//         MaterialPage(
//           name: 'BooksListPage',
//           key: ValueKey('BooksListPage'),
//           child: BooksListScreen(
//             books: books,
//             onTapped: _handleBookTapped,
//           ),
//         ),
//         if (show404)
//           MaterialPage(
//             name: 'UnknownPage',
//             key: ValueKey('UnknownPage'),
//             child: UnknownScreen(),
//           )
//         else if (_selectedBook != null)
//           BookDetailsPage(
//             book: _selectedBook!,
//           )
//       ],
//       onPopPage: (route, result) {
//         if (!route.didPop(result)) {
//           return false;
//         }

//         // Update the list of pages by setting _selectedBook to null
//         _selectedBook = null;
//         show404 = false;
//         notifyListeners();

//         return true;
//       },
//     );
//   }
// }

// class Book {
//   final String title;
//   final String author;

//   Book(this.title, this.author);
// }

// class BookDetailsPage extends Page {
//   final Book book;

//   BookDetailsPage({required this.book})
//       : super(
//           key: ValueKey(book),
//           name: 'BookDetailsPage$book',
//         );

//   Route createRoute(BuildContext context) {
//     return MaterialPageRoute(
//       settings: this,
//       builder: (BuildContext context) {
//         return BookDetailsScreen(book: book);
//       },
//     );
//   }
// }

// class BooksListScreen extends StatelessWidget {
//   final List<Book> books;
//   final ValueChanged<Book> onTapped;

//   BooksListScreen({
//     required this.books,
//     required this.onTapped,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: ListView(
//         children: [
//           for (var book in books)
//             ListTile(
//               title: Text(book.title),
//               subtitle: Text(book.author),
//               onTap: () => onTapped(book),
//             )
//         ],
//       ),
//     );
//   }
// }

// class BookDetailsScreen extends StatelessWidget {
//   final Book book;

//   BookDetailsScreen({required this.book});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(book.title, style: Theme.of(context).textTheme.headline6),
//             Text(book.author, style: Theme.of(context).textTheme.subtitle1),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class UnknownScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Center(
//         child: Text('404!'),
//       ),
//     );
//   }
// }
