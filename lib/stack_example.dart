// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   final delegate = MyRouteDelegate();

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp.router(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       routeInformationParser: MyRouteParser(),
//       routerDelegate: delegate,
//     );
//   }
// }

// class MyRouteParser extends RouteInformationParser<String> {
//   @override
//   Future<String> parseRouteInformation(RouteInformation routeInformation) {
//     print('parseRouteInformation: ${routeInformation.toString()}');
//     return SynchronousFuture(routeInformation.location ?? '');
//   }

//   @override
//   RouteInformation restoreRouteInformation(String configuration) {
//     print('restoreRouteInformation: ${configuration.toString()}');
//     return RouteInformation(location: configuration);
//   }
// }

// class MyRouteDelegate extends RouterDelegate<String>
//     with PopNavigatorRouterDelegateMixin<String>, ChangeNotifier {
//   MyRouteDelegate(List<Page<Object>>? pages) {
//     _stack.addAll(pages);
//   }

//   static MyRouteDelegate of(BuildContext context) {
//     final delegate = Router.of(context).routerDelegate;
//     assert(delegate is MyRouteDelegate, 'Delegate type must match');
//     return delegate as MyRouteDelegate;
//   }

//   @override
//   GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

//   @override
//   String get currentConfiguration => _stack.last;

//   List<Page> get stack => List.unmodifiable(_stack);
//   final _stack = <Page>[];

//   /// add to last index
//   void push(Page page) {
//     _stack.add(page);
//     notifyListeners();
//   }

//   /// add after [afterPage]
//   bool add(Page page, Page afterPage) {
//     final index = _stack.indexOf(afterPage);
//     if (index == -1) {
//       return false;
//     }
//     _stack.insert(index + 1, page);
//     notifyListeners();
//     return true;
//   }

//   bool addFresh(Page page) {}

//   bool pop() {
//     if (_stack.isNotEmpty) {
//       _stack.removeLast();
//       notifyListeners();
//       return true;
//     }
//     return false;
//   }

//   bool remove(Page page) {
//     final index = _stack.indexOf(page);
//     if (index == -1) {
//       return false;
//     }
//     _stack.remove(page);
//     notifyListeners();
//     return true;
//   }

//   bool _onPopPage(Route<dynamic> route, dynamic result) {
//     remove(route.settings as Page);
//     return route.didPop(result);
//   }
//   //   bool _onPopPage(Route<dynamic> route, dynamic result) {
//   //   if (_stack.isNotEmpty) {
//   //     if (_stack.last == route.settings.name) {
//   //       _stack.remove(route.settings.name);
//   //       notifyListeners();
//   //     }
//   //   }
//   //   return route.didPop(result);
//   // }

//   @override
//   Future<void> setInitialRoutePath(String configuration) {
//     return setNewRoutePath(configuration);
//   }

//   @override
//   Future<void> setNewRoutePath(String configuration) {
//     _stack
//       ..clear()
//       ..add(configuration);
//     return SynchronousFuture<void>(null);
//   }

//   @override
//   Widget build(BuildContext context) {
//     print('${describeIdentity(this)}.stack: $_stack');
//     return Navigator(
//       key: navigatorKey,
//       onPopPage: _onPopPage,
//       pages: [],
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

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key? key, required this.title}) : super(key: key);

//   final String title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   static int _counter = 0;

//   void _showDialog() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           content: Text('Is this being displayed?'),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(false),
//               child: Text('NO'),
//             ),
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(true),
//               child: Text('YES'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _removeLast() {
//     final delegate = MyRouteDelegate.of(context);
//     final stack = delegate.stack;
//     if (stack.length > 2) {
//       delegate.remove(stack[stack.length - 2]);
//     }
//   }

//   void _incrementCounter() {
//     setState(() {
//       _counter++;
//     });
//     MyRouteDelegate.of(context).push(

//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headline4,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           FloatingActionButton(
//             heroTag: 'dialog',
//             onPressed: _showDialog,
//             tooltip: 'Show dialog',
//             child: Icon(Icons.message),
//           ),
//           SizedBox(width: 12.0),
//           FloatingActionButton(
//             heroTag: 'remove',
//             onPressed: _removeLast,
//             tooltip: 'Remove last',
//             child: Icon(Icons.delete),
//           ),
//           SizedBox(width: 12.0),
//           FloatingActionButton(
//             heroTag: 'add',
//             onPressed: _incrementCounter,
//             tooltip: 'Increment',
//             child: Icon(Icons.add),
//           ),
//         ],
//       ),
//     );
//   }
// }
