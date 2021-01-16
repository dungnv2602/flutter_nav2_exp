import 'package:auto_route/auto_route.dart';
import 'package:flutter_nav_2/auto_route_demo/web/router/web_router.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Settings'),
            const SizedBox(height: 24),
            RaisedButton(
                child: Text('Books'),
                onPressed: () {
                  context.router.navigate(BooksRoute());
                })
          ],
        ),
      ),
    );
  }
}
