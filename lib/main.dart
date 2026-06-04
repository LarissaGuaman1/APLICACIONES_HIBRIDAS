import 'package:flutter/material.dart';
import 'routes/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class AppColors {
  static const Color fondo = Color(0xFFFFF6FB);
  static const Color rosa = Color(0xFFFFB6D9);
  static const Color lila = Color(0xFFD8B4FE);
  static const Color celeste = Color(0xFFA7D8FF);
  static const Color crema = Color(0xFFFFF1B8);
  static const Color texto = Color(0xFF5B3A70);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mi Biblioteca Kawaii',
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.login,
      onGenerateRoute: AppRoutes.generateRoute,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.fondo,
        fontFamily: 'Arial',
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.lila,
          foregroundColor: AppColors.texto,
          centerTitle: true,
          elevation: 0,
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.lila,
          primary: AppColors.lila,
          secondary: AppColors.rosa,
        ),
      ),
    );
  }
}