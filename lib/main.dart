import 'package:flutter/material.dart';
import 'package:life_restart/constants/strings.dart' as strings;
import 'package:life_restart/core/index.dart';
import 'package:life_restart/screens/home_screen.dart';
import 'package:life_restart/stores/theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<ThemeStore>(
          create: (context) => ThemeStore()..initialize()),
      ChangeNotifierProvider<CoreDelegate>(
          create: (context) => CoreDelegate()..initialize()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeStore>(
      builder: (context, themeStore, child) {
        return MaterialApp(
          title: strings.appName,
          theme: themeStore.lightTheme,
          darkTheme: themeStore.darkTheme,
          themeMode: themeStore.currentMode.mode,
          home: child,
        );
      },
      child: const HomeScreen(),
    );
  }
}
