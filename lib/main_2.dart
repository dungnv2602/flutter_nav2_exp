// import 'dart:convert';

// import 'package:flutter/material.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatefulWidget {
//   @override
//   MyAppState createState() => MyAppState();
// }

// class MyAppState extends State<MyApp> {
//   // This widget is the root of your application.
//   MyRouterDelegate _delegate = MyRouterDelegate();
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp.router(
//       title: 'Flutter Demo',
//       routeInformationParser: MyRouteInformationParser(),
//       routerDelegate: _delegate,
//     );
//   }
// }

// // {
// //   '/': (_) => MyHomePage(),
// //   '/tab': (_) => MyTabPage(),
// // }
// enum MyRoute { home, tab }

// // class MyConfiguration {
// //   const MyConfiguration(
// //     this.myRoute,
// //   );
// //   final MyRoute myRoute;

// //   @override
// //   bool operator ==(Object o) {
// //     if (identical(this, o)) return true;

// //     return o is MyConfiguration && o.myRoute == myRoute;
// //   }

// //   @override
// //   int get hashCode => myRoute.hashCode;

// //   @override
// //   String toString() => 'MyConfiguration(myRoute: $myRoute)';
// // }

// // class MyRouteInformationParser extends RouteInformationParser<MyConfiguration> {
// //   @override
// //   Future<MyConfiguration> parseRouteInformation(
// //       RouteInformation routeInformation) async {
// //     final String routeName = routeInformation.location ?? '';
// //     if (routeName == '/')
// //       return MyConfiguration(MyRoute.home);
// //     else if (routeName == '/tab') return MyConfiguration(MyRoute.tab);
// //     throw 'unknown';
// //   }

// //   @override
// //   RouteInformation restoreRouteInformation(MyConfiguration configuration) {
// //     switch (configuration.myRoute) {
// //       case MyRoute.home:
// //         return RouteInformation(location: '/');
// //       case MyRoute.tab:
// //         return RouteInformation(location: '/tab');
// //     }
// //   }
// // }



// class MyConfiguration {
//   const MyConfiguration(
//     this.myRoute,
//     this.tab,
//   );
//   final MyRoute myRoute;
//   final int? tab;

//   @override
//   bool operator ==(Object o) {
//     if (identical(this, o)) return true;

//     return o is MyConfiguration && o.myRoute == myRoute && o.tab == tab;
//   }

//   @override
//   int get hashCode => myRoute.hashCode ^ tab.hashCode;

//   @override
//   String toString() => 'MyConfiguration(myRoute: $myRoute, tab: $tab)';
// }

// class MyRouteInformationParser extends RouteInformationParser<MyConfiguration> {
//   @override
//   Future<MyConfiguration> parseRouteInformation(
//       RouteInformation routeInformation) async {
//     final String routeName = routeInformation.location ?? '';
//     if (routeName == '/')
//       return MyConfiguration(MyRoute.home, routeInformation.state as int?);
//     else if (routeName == '/tab')
//       return MyConfiguration(MyRoute.tab, routeInformation.state as int?);
//     throw 'unknown';
//   }

//   @override
//   RouteInformation restoreRouteInformation(MyConfiguration configuration) {
//     switch (configuration.myRoute) {
//       case MyRoute.home:
//         return RouteInformation(location: '/', state: configuration.tab);
//       case MyRoute.tab:
//         return RouteInformation(location: '/tab', state: configuration.tab);
//     }
//   }
// }

// class MyRouterDelegate extends RouterDelegate<MyConfiguration>
//     with ChangeNotifier, PopNavigatorRouterDelegateMixin<MyConfiguration> {
//   static MyRouterDelegate of(BuildContext context) {
//     final delegate = Router.of(context).routerDelegate;
//     assert(delegate is MyRouterDelegate, 'Delegate type must match');
//     return delegate as MyRouterDelegate;
//   }

//   @override
//   final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

//   MyConfiguration? get config => _config;
//   MyConfiguration? _config;
//   set config(MyConfiguration? value) {
//     if (_config == value) return;
//     _config = value;
//     notifyListeners();
//   }

//   // MyRoute get myRoute => _myRoute;
//   // MyRoute _myRoute = MyRoute.home;
//   // set myRoute(MyRoute value) {
//   //   if (_myRoute == value) return;
//   //   _myRoute = value;
//   //   notifyListeners();
//   // }

//   // int get tab => _tab;
//   // int _tab = 0;
//   // set tab(int value) {
//   //   if (_tab == value) return;
//   //   _tab = value;
//   //   notifyListeners();
//   // }

//   @override
//   Future<void> setNewRoutePath(MyConfiguration? configuration) async {
//     config = configuration;
//   }

//   // For web application
//   @override
//   // MyConfiguration get currentConfiguration => MyConfiguration(myRoute, tab);

//   MyConfiguration? get currentConfiguration => config;

//   bool _handlePopPage(Route<dynamic> route, dynamic result) {
//     final bool success = route.didPop(result);
//     if (success) {
//       config = MyConfiguration(MyRoute.home, 0);
//       notifyListeners();
//     }
//     return success;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Navigator(
//       key: navigatorKey,
//       pages: <Page<void>>[
//         MaterialPage(key: ValueKey('home'), child: MyHomePage()),
 
//       ],
//       onPopPage: _handlePopPage,
//     );
//   }
// }

// class MyHomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('home')),
//       body: Center(
//           child:
          
          
          
          
          



//           ,
          
          
          


//            ),
//     );
//   }
// }

// class DetailsPage extends StatelessWidget {
//   const DetailsPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
