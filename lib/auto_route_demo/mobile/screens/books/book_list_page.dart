import 'package:flutter_nav_2/auto_route_demo/data/db.dart';
import 'package:flutter_nav_2/auto_route_demo/mobile/router/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookListPage extends StatelessWidget {
  BookListPage(final String id);
  @override
  Widget build(BuildContext context) {
    var booksDb = Provider.of<BooksDB>(context);
    return ListView(
      children: booksDb.books
          .map((book) => Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  title: Text(book.name),
                  subtitle: Text(book.genre),
                  onTap: () {
                    // context.router.push(BookDetailsRoute(id: book.id));
                    BookDetailsRoute(id: book.id).show(context);
                  },
                ),
              ))
          .toList(),
    );
  }
}
