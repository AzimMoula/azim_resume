import 'package:flutter/material.dart';

import 'app.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final scrollbarTheme = ScrollbarThemeData(
      thumbVisibility: WidgetStateProperty.all(true),
    );

    return MaterialApp(
      theme: ThemeData.light().copyWith(scrollbarTheme: scrollbarTheme),
      darkTheme: ThemeData.dark().copyWith(scrollbarTheme: scrollbarTheme),
      title: 'Flutter PDF Demo',
      home: const MyApp(),
    );
  }
}