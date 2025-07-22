import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const UserDashboardApp());
}

class UserDashboardApp extends StatelessWidget {
  const UserDashboardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'User Dashboard',

      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(
          seedColor: CupertinoColors.systemBlue,
          brightness: Brightness.light,
        )
      ),
      darkTheme: ThemeData(
          useMaterial3: true,
          brightness: Brightness.dark,
          colorScheme: ColorScheme.fromSeed(
            seedColor: CupertinoColors.systemBlue,
            brightness: Brightness.dark,
          )
      ),
      themeMode: ThemeMode.system,


    );
  }
}
