import 'package:flutter/material.dart';

import '../main.dart';
import '../routes/app_routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Widget drawerItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String route,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppColors.texto),
      title: Text(
        title,
        style: const TextStyle(
          color: AppColors.texto,
          fontWeight: FontWeight.w600,
        ),
      ),
      onTap: () {
        Navigator.pop(context);
        Navigator.pushReplacementNamed(context, route);
      },
    );
  }

  Drawer menuDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.fondo,
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.rosa,
                  AppColors.lila,
                  AppColors.celeste,
                ],
              ),
            ),
            accountName: const Text(
              'Lectora Kawaii',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.texto,
              ),
            ),
            accountEmail: const Text(
              'reseñas@biblioteca.com',
              style: TextStyle(color: AppColors.texto),
            ),
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(
                Icons.menu_book_rounded,
                color: AppColors.texto,
                size: 36,
              ),
            ),
          ),
          drawerItem(
            context: context,
            icon: Icons.home_rounded,
            title: 'Inicio',
            route: AppRoutes.home,
          ),
          drawerItem(
            context: context,
            icon: Icons.rate_review_rounded,
            title: 'Agregar reseña',
            route: AppRoutes.review,
          ),
          drawerItem(
            context: context,
            icon: Icons.comment_rounded,
            title: 'Mis reseñas',
            route: AppRoutes.myReviews,
          ),
          drawerItem(
            context: context,
            icon: Icons.star_rounded,
            title: 'Libros recomendados',
            route: AppRoutes.recommended,
          ),
          drawerItem(
            context: context,
            icon: Icons.info_rounded,
            title: 'Acerca de',
            route: AppRoutes.about,
          ),
          const Spacer(),
          ListTile(
            leading: const Icon(Icons.logout_rounded, color: AppColors.texto),
            title: const Text(
              'Cerrar sesión',
              style: TextStyle(
                color: AppColors.texto,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              Navigator.pushReplacementNamed(context, AppRoutes.login);
            },
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget cardHome({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      color: Colors.white,
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 18),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(26),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(18),
        leading: CircleAvatar(
          radius: 28,
          backgroundColor: AppColors.crema,
          child: Icon(icon, color: AppColors.texto, size: 30),
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: AppColors.texto,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios_rounded),
        onTap: onTap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: menuDrawer(context),
      appBar: AppBar(
        title: const Text('Mi Biblioteca Kawaii'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(22),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    AppColors.rosa,
                    AppColors.lila,
                  ],
                ),
                borderRadius: BorderRadius.circular(32),
              ),
              child: const Column(
                children: [
                  Icon(
                    Icons.auto_stories_rounded,
                    size: 75,
                    color: AppColors.texto,
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Bienvenida a tu rincón lector',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.texto,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Guarda reseñas, comentarios y recomendaciones de tus libros favoritos.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.texto,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),
            cardHome(
              icon: Icons.rate_review_rounded,
              title: 'Agregar reseña',
              subtitle: 'Registra un libro y tu opinión.',
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.review);
              },
            ),
            cardHome(
              icon: Icons.comment_rounded,
              title: 'Mis reseñas',
              subtitle: 'Consulta tus comentarios guardados.',
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.myReviews);
              },
            ),
            cardHome(
              icon: Icons.star_rounded,
              title: 'Libros recomendados',
              subtitle: 'Mira sugerencias de lectura.',
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.recommended);
              },
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, '/ruta-que-no-existe');
                },
                icon: const Icon(Icons.warning_rounded),
                label: const Text('Probar ruta no existente'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.celeste,
                  foregroundColor: AppColors.texto,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}