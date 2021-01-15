// // TODO(joe): https://github.com/flutter/flutter/issues/69315#issuecomment-722038062

// // TODO(joe): https://docs.google.com/document/d/1Q0jx0l4-xymph9O6zLaOY4d_f7YFpNWX_eGbzYxr9wY/edit#
// // TODO(joe): full control vs targeted modifications
// // TODO(joe): initial route
// // TODO(joe): sub-router/nested-navigation
// // TODO(joe): dynamically access route stack
// // TODO(joe): intergrate restoration framework
// // TODO(joe): save nav history => refer to it directly when open app again
// // TODO(joe): DirectionalTransition, CupertinoDirectionTransition on Nav 2

// // TODO(joe): write an article about my take on Nav 2 + State Restoration

// import 'package:flutter/foundation.dart';

// /// you have full controll over route stack and customize how to transition each route. For example, you cannot remove three routes in the middle with the navigator 1.0 API.
// ///
// /// you have complete control over what to do when user press android back button. This become more promising when you have more than one navigator in the widget tree.
// ///
// /// Web use case as you mentioned.
// ///
// /// you also have full control over how to parse the initial route. In the Navigator 1.0, the initial route is parsed by / and will create a stack of routes, and you cannot update the initial route once it is built.

// /// The popRoute() method is called by the Router when the backButtonDispatcher reports that the operating system is requesting that the current route should be popped. This will likely cause the route delegate to forward the pop to the Navigator previously returned by its build method. If the routeDelegate was able to handle the pop, it should return true. Otherwise it should return false. Returning false may pop the route of a surrounding Navigator (which may be the SystemNavigator), depending on the concrete implementation of the backButtonDispatcher.
// ///
// ///

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

// /// [_onPopPage] - To use the Pages API we must implement this callback. Navigator uses this to report back when the a route for a page is popped. We use this to update our pages list to remove the page for the route. Otherwise, the next time the pages list is updated it will interpret the page as a new route and display it.

// /// [transitionDelegate] - This is nothing to do directly with animation. This is used by Navigator to determine if a change to the pages list indicates a push, pop or even add.
// /// This default transition delegate follows these rules.
// /// * Firstly, all the entering routes are placed on top of the exiting routes if they are at the same location.
// /// * Secondly, the top most route will always transition with an animated transition.
// /// * All the other routes below will either be completed or added without an animated transition.

// /// [reportsRouteUpdateToEngine]: only care about this when using [Page] without [Router]

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
