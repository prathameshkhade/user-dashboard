import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:userdashboard/features/users/presentation/bloc/user_bloc.dart';
import 'package:userdashboard/features/users/presentation/screens/dashboard_screen.dart';
import 'package:userdashboard/init_dependencies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<UserBloc>())
      ],
      child: const UserDashboardApp(),
    )
  );
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

      home: const DashboardScreen(),
    );
  }
}
