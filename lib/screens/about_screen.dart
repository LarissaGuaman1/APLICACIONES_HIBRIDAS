import 'package:flutter/material.dart';

import '../main.dart';
import 'home_screen.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const HomeScreen().menuDrawer(context),
      appBar: AppBar(
        title: const Text('Acerca de'),
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(24),
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(32),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 12,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.auto_stories_rounded,
                size: 80,
                color: AppColors.lila,
              ),
              SizedBox(height: 18),
              Text(
                'Mi Biblioteca Kawaii',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.texto,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 14),
              Text(
                'Aplicación móvil desarrollada en Flutter para registrar reseñas, comentarios, calificaciones y recomendaciones de libros. También permite guardar reseñas sin internet usando SQLite y sincronizarlas cuando vuelva la conexión.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}