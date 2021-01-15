// import 'package:flutter/material.dart';
// import 'package:url_strategy/url_strategy.dart';

// void main() {
//   // Here we set the URL strategy for our web app.
//   // It is safe to call this function when running on mobile or desktop as well.
//   setPathUrlStrategy();
//   runApp(MyApp());
// }

// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   final _routerDelegate = BookRouterDelegate();
//   final _routeInformationParser = BookRouteInformationParser();
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp.router(
//       title: 'Book Review App',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         appBarTheme: AppBarTheme(
//           color: Colors.white,
//           iconTheme: IconThemeData(color: Colors.black),
//           elevation: 0,
//         ),
//       ),
//       routerDelegate: _routerDelegate,
//       routeInformationParser: _routeInformationParser,
//     );
//   }
// }

// class BookRouterDelegate extends RouterDelegate<BookRoutePath>
//     with ChangeNotifier, PopNavigatorRouterDelegateMixin<BookRoutePath> {
//   BookRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>();

//   final GlobalKey<NavigatorState> navigatorKey;

//   Book _selectedBook;
//   bool show404 = false;

//   void _handleBookTapped(Book book) {
//     _selectedBook = book;
//     notifyListeners();
//   }

//   // show the correct path in the url, need to return a book
//   // book route path based on current state of the app
//   BookRoutePath get currentConfiguration {
//     if (show404) print('currentConfiguration: 404');

//     if (show404) return BookRoutePath.unknown();

//     if (_selectedBook == null) return BookRoutePath.home();

//     return BookRoutePath.details(books.indexOf(_selectedBook));
//   }

//   // when update of route, updates the app state
//   @override
//   Future<void> setNewRoutePath(BookRoutePath path) async {
//     if (path.isUnknown) {
//       _selectedBook = null;
//       show404 = true;
//       // have an empty return to end the function
//       return;
//     }

//     if (path.isDetailsPage) {
//       if (path.id < 0 || path.id > books.length - 1) {
//         show404 = true;
//         return;
//       }
//       _selectedBook = books[path.id];
//     } else {
//       _selectedBook = null;
//     }

//     print('setNewRoutePath: isHomePage:${path.isHomePage}');
//     show404 = false;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Navigator(
//       key: navigatorKey,
//       pages: [
//         MaterialPage<Object>(
//           key: const ValueKey('HomePage'),
//           child: HomePage(
//             books: books,
//             onTapped: _handleBookTapped,
//           ),
//         ),
//         if (show404)
//           MaterialPage<Object>(
//               key: const ValueKey('UnknownPage'), child: UnknownScreen())
//         else if (_selectedBook != null)
//           BookDetailsPage(book: _selectedBook),
//       ],
//       onPopPage: (route, Object result) {
//         if (!route.didPop(result)) {
//           return false;
//         }

//         _selectedBook = null;
//         show404 = false;
//         notifyListeners();

//         return true;
//       },
//     );
//   }
// }

// class BookRouteInformationParser extends RouteInformationParser<BookRoutePath> {
//   // Converts the given route information into parsed data to pass to a
//   // RouterDelegate
//   @override
//   Future<BookRoutePath> parseRouteInformation(
//       RouteInformation routeInfo) async {
//     if (routeInfo.location == null) {
//       print('parseRouteInformation: null');
//     }

//     final uri = Uri.parse(routeInfo.location ?? '/');

//     // Handle '/'
//     if (uri.pathSegments.length == 0) return BookRoutePath.home();

//     // Handle 'book/:id'
//     if (uri.pathSegments.length == 2) {
//       if (uri.pathSegments.first != 'book') return BookRoutePath.unknown();
//       final remaining = uri.pathSegments.elementAt(1);
//       final id = int.tryParse(remaining);
//       if (id == null) return BookRoutePath.unknown();
//       return BookRoutePath.details(id);
//     }

//     // Handle unknown routes
//     return BookRoutePath.unknown();
//   }

//   // which is used for updating browser history for the web application. If you
//   // decides to opt in, you must also overrides this method to return a route
//   // information.
//   @override
//   RouteInformation restoreRouteInformation(BookRoutePath path) {
//     if (path.isUnknown) {
//       return RouteInformation(location: '/404');
//     }
//     if (path.isHomePage) {
//       return RouteInformation(location: '/');
//     }
//     if (path.isDetailsPage) {
//       return RouteInformation(location: '/book/${path.id}');
//     }

//     print('restoreRouteInformation: null');

//     return RouteInformation(location: null);
//   }
// }

// class BookRoutePath {
//   final int id;
//   final bool isUnknown;

//   BookRoutePath.home()
//       : id = null,
//         isUnknown = false;

//   BookRoutePath.details(this.id) : isUnknown = false;

//   BookRoutePath.unknown()
//       : id = null,
//         isUnknown = true;

//   bool get isHomePage => id == null;

//   bool get isDetailsPage => id != null;
// }

// class BookDetailsPage extends Page<Object> {
//   final Book book;

//   BookDetailsPage({
//     @required this.book,
//   }) : super(key: ValueKey(book));

//   Route createRoute(BuildContext context) {
//     return MaterialPageRoute<Object>(
//       settings: this,
//       builder: (BuildContext context) {
//         return BookPage(book: book);
//       },
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

// class HomePage extends StatelessWidget {
//   final List<Book> books;
//   final ValueChanged<Book> onTapped;
//   const HomePage({Key key, @required this.books, @required this.onTapped})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 18.0),
//         child: Column(children: [
//           SizedBox(height: 20),
//           FakeAppBar(),
//           SizedBox(height: 20),
//           FakeTabBar(),
//           SizedBox(height: 20),
//           Expanded(
//             child: GridView.count(
//               childAspectRatio: 48 / 78,
//               shrinkWrap: true,
//               crossAxisCount: 2,
//               children: List.generate(books.length, (index) {
//                 final book = books[index];
//                 return InkWell(
//                   onTap: () => onTapped(book),
//                   child: Card(
//                     child: Image.asset(
//                       book.image,
//                       fit: BoxFit.fill,
//                     ),
//                   ),
//                 );
//               }),
//             ),
//           )
//         ]),
//       ),
//     );
//   }
// }

// class BookPage extends StatelessWidget {
//   final Book book;

//   const BookPage({Key key, @required this.book}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         actions: [
//           IconButton(onPressed: () {}, icon: Icon(Icons.more_horiz)),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             UpperTextSection(book: book),
//             SizedBox(height: 30),
//             MidImageSection(image: book.image),
//             SizedBox(height: 30),
//             BottomTextSection(),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class BottomTextSection extends StatelessWidget {
//   const BottomTextSection({
//     Key key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 18.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Text(
//                 '4.7',
//                 style: TextStyle(fontSize: 30, color: Colors.blue.shade900),
//               ),
//               SizedBox(width: 10),
//               for (var i = 0; i < 5; i++)
//                 Icon(
//                   Icons.star_rounded,
//                   color: Colors.yellow.shade700,
//                   size: 25,
//                 ),
//             ],
//           ),
//           SizedBox(height: 15),
//           Text(
//             '892 rating in Google Play',
//             style: TextStyle(
//               color: Colors.grey,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//           SizedBox(height: 15),
//           Text(
//             _bookReview,
//             style: TextStyle(
//               fontSize: 16,
//               color: Colors.blue.shade900,
//               height: 2,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class MidImageSection extends StatelessWidget {
//   const MidImageSection({
//     Key key,
//     @required this.image,
//   }) : super(key: key);

//   final String image;

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 200,
//       width: MediaQuery.of(context).size.width,
//       child: Stack(
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(left: 18.0),
//             child: ClipRRect(
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(20),
//                 bottomLeft: Radius.circular(20),
//               ),
//               child: Image.asset(
//                 image,
//                 width: MediaQuery.of(context).size.width,
//                 fit: BoxFit.fitWidth,
//               ),
//             ),
//           ),
//           Align(
//             alignment: Alignment.bottomRight,
//             child: Padding(
//               padding: const EdgeInsets.only(bottom: 10.0),
//               child: Row(
//                 children: [
//                   Spacer(),
//                   FlatButton(
//                     height: 50,
//                     minWidth: 50,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     color: Colors.deepOrange,
//                     child: Icon(
//                       Icons.info_outline,
//                       color: Colors.white,
//                     ),
//                     onPressed: () {},
//                   ),
//                   SizedBox(
//                     width: 10,
//                   ),
//                   FlatButton.icon(
//                     height: 50,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     color: Colors.blue.shade900,
//                     icon: Icon(
//                       Icons.play_arrow_outlined,
//                       color: Colors.white,
//                     ),
//                     label: Text(
//                       'Audio Book',
//                       style: TextStyle(
//                         color: Colors.white,
//                       ),
//                     ),
//                     onPressed: () {},
//                   ),
//                   SizedBox(
//                     width: 10,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class UpperTextSection extends StatelessWidget {
//   final Book book;
//   const UpperTextSection({
//     Key key,
//     @required this.book,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 18.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(height: 20),
//           Text(
//             'History'.toUpperCase(),
//             style: TextStyle(
//               color: Colors.deepOrange,
//               fontSize: 12,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//           SizedBox(height: 10),
//           Text(
//             book.title,
//             style: TextStyle(fontSize: 29, color: Colors.blue.shade900),
//           ),
//           SizedBox(height: 15),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               RichText(
//                 text: TextSpan(
//                   text: 'Writtern by ',
//                   style: DefaultTextStyle.of(context).style.copyWith(
//                         fontWeight: FontWeight.w500,
//                         color: Colors.grey,
//                       ),
//                   children: <TextSpan>[
//                     TextSpan(
//                       text: book.author,
//                       style: TextStyle(color: Colors.blue.shade900),
//                     ),
//                   ],
//                 ),
//               ),
//               Text(
//                 '23 Mar, 2019',
//                 style: TextStyle(
//                   color: Colors.grey,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }

// final _bookReview = '''
// An extremely powerful story of a young Southern Negro, from his late high school days through three years of college to his life in Harlem.
// His early training prepared him for a life of humility before white men, but through injustices- large and small, he came to realize that he was an "invisible man". People saw in him only a reflection of their preconceived ideas of what he was, denied his individuality, and ultimately did not see him at all. This theme, which has implications far beyond the obvious racial parallel, is skillfully handled. The incidents of the story are wholly absorbing. The boy's dismissal from college because of an innocent mistake, his shocked reaction to the anonymity of the North and to Harlem, his nightmare experiences on a one-day job in a paint factory and in the hospital, his lightning success as the Harlem leader of a communistic organization known as the Brotherhood, his involvement in black versus white and black versus black clashes and his disillusion and understanding of his invisibility- all climax naturally in scenes of violence and riot, followed by a retreat which is both literal and figurative. Parts of this experience may have been told before, but never with such freshness, intensity and power.
// This is Ellison's first novel, but he has complete control of his story and his style. Watch it.
// ''';

// class FakeAppBar extends StatelessWidget {
//   const FakeAppBar({
//     Key key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Icon(Icons.menu),
//         buildText('All Books'),
//         Icon(Icons.search),
//       ],
//     );
//   }
// }

// class FakeTabBar extends StatelessWidget {
//   const FakeTabBar({
//     Key key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 55,
//       child: Container(
//         color: Colors.grey.shade200,
//         child: Padding(
//           padding: EdgeInsets.all(4),
//           child: Row(
//             children: [
//               Expanded(
//                 child: Container(
//                   padding: EdgeInsets.all(4),
//                   color: Colors.white,
//                   child: Center(child: buildText('Ebooks')),
//                 ),
//               ),
//               Expanded(
//                 child: Container(
//                   padding: EdgeInsets.all(4),
//                   child: Center(child: buildText('Audiobooks')),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// Text buildText(String text) {
//   return Text(
//     text,
//     style: TextStyle(
//       fontSize: 17,
//       fontWeight: FontWeight.w500,
//       color: Colors.black,
//     ),
//   );
// }

// class Book {
//   final String title;
//   final String author;
//   final String image;

//   Book(this.title, {@required this.author, @required this.image});
// }

// final books = [
//   Book(
//     'This Is the Way',
//     author: 'Gavin Corbett',
//     image: 'images/1.jpg',
//   ),
//   Book(
//     'Her',
//     author: 'Spike Jonze',
//     image: 'images/2.jpg',
//   ),
//   Book(
//     'Fight Club',
//     author: 'David Fincher',
//     image: 'images/3.jpg',
//   ),
//   Book(
//     'Enemy',
//     author: 'Javier Gullón',
//     image: 'images/4.jpg',
//   ),
//   Book(
//     'Manual to Minimalism',
//     author: 'Unknown',
//     image: 'images/5.jpg',
//   ),
//   Book(
//     'Dirty Harry',
//     author: 'Don Siegel',
//     image: 'images/6.jpg',
//   ),
// ];
