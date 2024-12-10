import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/perexod.dart';
import 'package:todo/themeprovader.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => Themeprovader(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Provider.of<Themeprovader>(context).themeData,
      themeMode: _themeMode,
      home: Perexod(),
    );
  }
}
