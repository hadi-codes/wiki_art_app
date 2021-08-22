import 'package:flutter/material.dart';
import 'package:wiki_art/pages/pages.dart';
import 'Theme/theme.dart';
import 'get_it.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setup();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.themeData,
      home: HomePage(),
    );
  }
}
