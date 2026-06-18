import 'package:flutter/material.dart';

import '../main.dart';
import '../routes/app_routes.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController usuarioController = TextEditingController();
  final TextEditingController correoController = TextEditingController();
  final TextEditingController claveController = TextEditingController();

  void registrar() {
    if (nombreController.text.isEmpty ||
        usuarioController.text.isEmpty ||
        correoController.text.isEmpty ||
        claveController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Complete todos los campos'),
          backgroundColor: Colors.pinkAccent,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Usuario registrado correctamente'),
          backgroundColor: Colors.purple,
        ),
      );

      Navigator.pushReplacementNamed(context, AppRoutes.login);
    }
  }

  Widget campoTexto({
    required String label,
    required IconData icon,
    required TextEditingController controller,
    bool ocultar = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller,
        obscureText: ocultar,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          filled: true,
          fillColor: AppColors.fondo,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(22),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    nombreController.dispose();
    usuarioController.dispose();
    correoController.dispose();
    claveController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.fondo,
      appBar: AppBar(
        title: const Text('Registrar usuario'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 12,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            children: [
              const Icon(
                Icons.person_add_alt_1_rounded,
                size: 75,
                color: AppColors.lila,
              ),
              const SizedBox(height: 12),
              const Text(
                'Crear cuenta lectora',
                style: TextStyle(
                  color: AppColors.texto,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 25),
              campoTexto(
                label: 'Nombre completo',
                icon: Icons.badge_outlined,
                controller: nombreController,
              ),
              campoTexto(
                label: 'Usuario',
                icon: Icons.person_outline,
                controller: usuarioController,
              ),
              campoTexto(
                label: 'Correo',
                icon: Icons.email_outlined,
                controller: correoController,
              ),
              campoTexto(
                label: 'Contraseña',
                icon: Icons.lock_outline,
                controller: claveController,
                ocultar: true,
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: registrar,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.rosa,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22),
                    ),
                  ),
                  child: const Text(
                    'REGISTRAR',
                    style: TextStyle(
                      color: AppColors.texto,
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}