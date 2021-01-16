import 'package:flutter_nav_2/auto_route_demo/data/db.dart';
import 'package:flutter_nav_2/auto_route_demo/mobile/router/router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData.dark(),
      routerDelegate: appRouter.delegate(),
      routeInformationParser: appRouter.defaultRouteParser(),
      builder: (_, router) {
        return Provider(
          create: (_) => BooksDB(),
          child: router,
        );
      },
    );
  }
}
