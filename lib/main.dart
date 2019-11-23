import 'package:flutter/material.dart';
import 'package:yq/page/doc_detail_page.dart';
import 'page/explore_page/explore_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: AppBarTheme(elevation: 0),
        primaryColor: Colors.white,
        accentColor: Color(0xFF25B864),
      ),
      home: DocDetailPage(),
    );
  }
}
