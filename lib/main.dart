// import 'package:flutter/foundation.dart';

// import 'package:flutter/material.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   // final navigatorKey = GlobalKey<NavigatorState>();

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp.router(
//       title: 'Material App',
//       routeInformationParser: MyRouteInformationParser(),
//       routerDelegate: MyRouterDelegate(
//           // navigatorKey: navigatorKey,
//           ),
//     );
//   }
// }

// class Home extends StatefulWidget {
//   @override
//   _HomeState createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }

// enum MyRoute { home, tab, unknown }

// extension RouteConfigX on MyRoute {
//   ValueKey<MyRoute> get valueKey => ValueKey(this);

//   String get path {
//     switch (this) {
//       case MyRoute.home:
//         return '/';

//       case MyRoute.tab:
//         return '/tab';

//       case MyRoute.unknown:
//         return '/404';
//     }
//   }

//   RouteInformation get routeInformation {
//     switch (this) {
//       case MyRoute.home:
//         return RouteInformation(location: '/');

//       case MyRoute.tab:
//         return RouteInformation(location: '/tab');

//       case MyRoute.unknown:
//         return RouteInformation(location: '/404');
//     }
//   }
// }

// MyRoute toRouteConfig(String? location) {
//   if (location == '/') return MyRoute.home;
//   if (location == '/tab') return MyRoute.tab;
//   if (location == '/404') return MyRoute.unknown;
//   throw Exception('location invalid');
// }

// class MyRouteInformationParser extends RouteInformationParser<MyRoute> {
//   /// When the delegates can perform their work entirely synchronously, then [SynchronousFuture] should be used in their implementations. This will allow the Router to proceed in a completely synchronous way, which may speed up things a bit. However, asynchronous work is completely supported by the Router if necessary.
//   ///
//   /// In this example, because we do not do asynchronous work,
//   /// so we don't need [async] in method declaration & we also return [SynchronousFuture].
//   ///
//   @override
//   Future<MyRoute> parseRouteInformation(
//       RouteInformation routeInformation) async {
//     return toRouteConfig(routeInformation.location);
//     // return SynchronousFuture<RouteConfig>(
//     //     toRouteConfig(routeInformation.location));
//   }

//   // for web application
//   @override
//   RouteInformation restoreRouteInformation(MyRoute configuration) {
//     return configuration.routeInformation;
//   }
// }



// class MyRouterDelegate extends RouterDelegate<MyRoute>
//     with ChangeNotifier, PopNavigatorRouterDelegateMixin<MyRoute> {
//   // MyRouterDelegate({required this.navigatorKey});

//   static MyRouterDelegate of(BuildContext context) {
//     final delegate = Router.of(context).routerDelegate;
//     assert(delegate is MyRouterDelegate, 'Delegate type must match');
//     return delegate as MyRouterDelegate;
//   }

//   final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

//   // @override
//   // GlobalKey<NavigatorState>? navigatorKey = GlobalKey<NavigatorState>();

//   MyRoute get routeConfig => _routeConfig;
//   MyRoute _routeConfig = MyRoute.home;
//   set routeConfig(MyRoute value) {
//     if (_routeConfig == value) return;
//     _routeConfig = value;
//     notifyListeners();
//   }

//   // for web application
//   @override
//   MyRoute get currentConfiguration => routeConfig;

//   @override
//   Future<void> setNewRoutePath(MyRoute configuration) async {
//     print('setNewRoutePath: ${configuration.toString()}');
//     routeConfig = configuration;
//     // return SynchronousFuture<void>(null);
//   }

//   /// Called when [pop] is invoked but the current [Route] corresponds to a
//   /// [Page] found in the [pages] list.
//   ///
//   /// The `result` argument is the value with which the route is to complete
//   /// (e.g. the value returned from a dialog).
//   ///
//   /// This callback is responsible for calling [Route.didPop] and returning
//   /// whether this pop is successful.
//   ///
//   /// The [Navigator] widget should be rebuilt with a [pages] list that does not
//   /// contain the [Page] for the given [Route]. The next time the [pages] list
//   /// is updated, if the [Page] corresponding to this [Route] is still present,
//   /// it will be interpreted as a new route to display.
//   ///
//   /// This act as an [interceptor], to decide if the [route] will be
//   /// allowed to poped or not.
//   ///
//   bool _onPopPage(Route<dynamic> route, dynamic result) {
//     final bool success = route.didPop(result);
//     if (success) {
//       routeConfig = MyRoute.home;
//     }
//     return success;
//   }

//   List<Page> _buildPages() {
//     return [
//       MaterialPage(key: ValueKey('home'), child: MyHomePage()),
//       if (routeConfig == MyRoute.tab)
//         MaterialPage(key: ValueKey('tab'), child: MyTabPage()),
//     ];
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Navigator(
//       // reportsRouteUpdateToEngine: false,
//       key: navigatorKey,
//       pages: _buildPages(),
//       onPopPage: _onPopPage,
//     );
//   }
// }

// class MyPage<T> extends Page<T> {
//   const MyPage({
//     LocalKey? key,
//     String? name,
//     Object? arguments,
//     String? restorationId,
//     this.maintainState = true,
//     this.fullscreenDialog = false,
//     required this.builder,
//   }) : super(
//           key: key,
//           name: name,
//           restorationId: restorationId,
//           arguments: arguments,
//         );

//   /// {@macro flutter.widgets.ModalRoute.maintainState}
//   final bool maintainState;

//   /// {@macro flutter.widgets.PageRoute.fullscreenDialog}
//   final bool fullscreenDialog;

//   final WidgetBuilder builder;

//   @override
//   Route<T> createRoute(BuildContext context) {
//     return MaterialPageRoute(
//       settings: this,
//       builder: builder,
//       fullscreenDialog: fullscreenDialog,
//       maintainState: maintainState,
//     );
//   }

//   @override
//   String toString() => '$name-$restorationId';
// }

// class MyHomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('home')),
//       body: Center(
//           child: Column(
//         children: <Widget>[
//           MaterialButton(
//             child: Text('open tab'),
//             onPressed: () {
//               MyRouterDelegate.of(context).routeConfig = MyRoute.tab;
//             },
//           )
//         ],
//       )),
//     );
//   }
// }

// class MyTabPage extends StatefulWidget {
//   @override
//   MyTabPageState createState() => MyTabPageState();
// }

// class MyTabPageState extends State<MyTabPage>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         bottom: TabBar(
//           controller: _tabController,
//           tabs: [
//             Tab(icon: Icon(Icons.directions_car)),
//             Tab(icon: Icon(Icons.directions_transit)),
//           ],
//         ),
//         title: Text('Tab'),
//       ),
//       body: TabBarView(
//         controller: _tabController,
//         children: [
//           Icon(Icons.directions_car),
//           Icon(Icons.directions_transit),
//         ],
//       ),
//     );
//   }
// }

// abstract class _RestorationInformation {
//   _RestorationInformation(this.type);
//   factory _RestorationInformation.named({
//     required String name,
//     required int restorationScopeId,
//   }) = _NamedRestorationInformation;
//   factory _RestorationInformation.anonymous({
//     required int restorationScopeId,
//   }) = _AnonymousRestorationInformation;

//   final bool type;
// }

// class _NamedRestorationInformation extends _RestorationInformation {
//   _NamedRestorationInformation({
//     required this.name,
//     required this.restorationScopeId,
//   }) : super(true);

//   final String name;
//   final int restorationScopeId;
// }

// class _AnonymousRestorationInformation extends _RestorationInformation {
//   _AnonymousRestorationInformation({
//     required this.restorationScopeId,
//   }) : super(false);

//   final int restorationScopeId;
// }
