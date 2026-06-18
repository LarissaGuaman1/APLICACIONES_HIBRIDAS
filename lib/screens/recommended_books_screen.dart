import 'package:flutter/material.dart';

import '../main.dart';
import 'home_screen.dart';

class RecommendedBooksScreen extends StatelessWidget {
  const RecommendedBooksScreen({super.key});

  Widget bookCard(String titulo, String genero) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: AppColors.rosa,
          child: Icon(Icons.star_rounded, color: AppColors.texto),
        ),
        title: Text(
          titulo,
          style: const TextStyle(
            color: AppColors.texto,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(genero),
        trailing: const Icon(Icons.favorite_rounded, color: Colors.pink),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const HomeScreen().menuDrawer(context),
      appBar: AppBar(
        title: const Text('Libros recomendados'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          bookCard('El Principito', 'Fantasía / Reflexión'),
          bookCard('Bajo la misma estrella', 'Romance / Drama'),
          bookCard('Harry Potter', 'Fantasía / Aventura'),
          bookCard('Orgullo y Prejuicio', 'Romance clásico'),
          bookCard('Cien años de soledad', 'Realismo mágico'),
        ],
      ),
    );
  }
}