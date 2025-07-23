import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'provider/task_provider.dart';
import 'provider/task_provider.dart';
import 'screens/splash_screen.dart';
import 'utils/theme.dart';

void main() {
  runApp(const TaskaApp());
}

class TaskaApp extends StatelessWidget {
  const TaskaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TaskProvider(),
      child: MaterialApp(
        title: 'Taska',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: ThemeMode.system,
        home: const SplashScreen(),
      ),
    );
  }
}
