import 'package:flutter/material.dart';
import '../main.dart';
import 'home_screen.dart';

class MyReviewsScreen extends StatelessWidget {
  const MyReviewsScreen({super.key});

  Widget reviewCard(String titulo, String comentario, String estrellas) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: AppColors.crema,
          child: Icon(Icons.menu_book_rounded, color: AppColors.texto),
        ),
        title: Text(
          titulo,
          style: const TextStyle(
            color: AppColors.texto,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text('$comentario\n$estrellas'),
        isThreeLine: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const HomeScreen().menuDrawer(context),
      appBar: AppBar(
        title: const Text('Mis reseñas'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          reviewCard(
            'El Principito',
            'Una historia tierna y reflexiva.',
            '⭐⭐⭐⭐⭐',
          ),
          reviewCard(
            'Orgullo y Prejuicio',
            'Me gustó la historia y sus personajes.',
            '⭐⭐⭐⭐',
          ),
          reviewCard(
            'Harry Potter',
            'Tiene magia, amistad y aventura.',
            '⭐⭐⭐⭐⭐',
          ),
        ],
      ),
    );
  }
}