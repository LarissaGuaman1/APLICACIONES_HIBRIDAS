import 'package:flutter/material.dart';
import '../main.dart';
import 'home_screen.dart';

class ReviewFormScreen extends StatefulWidget {
  const ReviewFormScreen({super.key});

  @override
  State<ReviewFormScreen> createState() => _ReviewFormScreenState();
}

class _ReviewFormScreenState extends State<ReviewFormScreen> {
  final TextEditingController libroController = TextEditingController();
  final TextEditingController fechaController = TextEditingController();
  final TextEditingController rangoController = TextEditingController();
  final TextEditingController horaController = TextEditingController();
  final TextEditingController comentarioController = TextEditingController();

  String generoSeleccionado = 'Fantasía';
  String estadoLibro = 'Leído';
  String calificacion = '5 estrellas';
  bool recomienda = true;

  final List<String> generos = [
    'Fantasía',
    'Romance',
    'Misterio',
    'Terror',
    'Aventura',
    'Drama',
  ];

  final List<String> estados = [
    'Leído',
    'Leyendo',
    'Pendiente',
  ];

  final List<String> etiquetas = [
    'Mágico',
    'Emocionante',
    'Romántico',
    'Triste',
    'Favorito',
  ];

  final List<String> emociones = [
    'Feliz',
    'Triste',
    'Sorprendida',
    'Inspirada',
  ];

  final List<String> emocionesSeleccionadas = ['Feliz'];

  Future<void> seleccionarFecha() async {
    DateTime? fecha = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    if (fecha != null) {
      setState(() {
        fechaController.text = '${fecha.day}/${fecha.month}/${fecha.year}';
      });
    }
  }

  Future<void> seleccionarRango() async {
    DateTimeRange? rango = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    if (rango != null) {
      setState(() {
        rangoController.text =
            '${rango.start.day}/${rango.start.month}/${rango.start.year} - '
            '${rango.end.day}/${rango.end.month}/${rango.end.year}';
      });
    }
  }

  Future<void> seleccionarHora() async {
    TimeOfDay? hora = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (hora != null) {
      setState(() {
        horaController.text = hora.format(context);
      });
    }
  }

  void guardarResena() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Reseña guardada correctamente'),
        backgroundColor: Colors.purple,
      ),
    );
  }

  Widget campoTitulo(String texto) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        texto,
        style: const TextStyle(
          color: AppColors.texto,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget tarjetaFormulario({
    required String titulo,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(26),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          campoTitulo(titulo),
          child,
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool pantallaGrande = MediaQuery.of(context).size.width > 750;

    return Scaffold(
      drawer: const HomeScreen().menuDrawer(context),
      appBar: AppBar(
        title: const Text('Agregar reseña'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: pantallaGrande
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: columnaUno()),
                  const SizedBox(width: 18),
                  Expanded(child: columnaDos()),
                ],
              )
            : Column(
                children: [
                  columnaUno(),
                  columnaDos(),
                ],
              ),
      ),
    );
  }

  Widget columnaUno() {
    return Column(
      children: [
        tarjetaFormulario(
          titulo: 'Buscar libro',
          child: Autocomplete<String>(
            optionsBuilder: (TextEditingValue value) {
              final libros = [
                'El Principito',
                'Orgullo y Prejuicio',
                'Harry Potter',
                'Bajo la misma estrella',
                'Cien años de soledad',
              ];

              if (value.text.isEmpty) {
                return libros;
              }

              return libros.where(
                (libro) => libro.toLowerCase().contains(
                      value.text.toLowerCase(),
                    ),
              );
            },
            onSelected: (String value) {
              libroController.text = value;
            },
          ),
        ),

        tarjetaFormulario(
          titulo: 'Fecha en que terminaste el libro',
          child: TextField(
            controller: fechaController,
            readOnly: true,
            onTap: seleccionarFecha,
            decoration: const InputDecoration(
              hintText: 'Selecciona una fecha',
              suffixIcon: Icon(Icons.calendar_month),
              border: OutlineInputBorder(),
            ),
          ),
        ),

        tarjetaFormulario(
          titulo: 'Tiempo de lectura',
          child: TextField(
            controller: rangoController,
            readOnly: true,
            onTap: seleccionarRango,
            decoration: const InputDecoration(
              hintText: 'Selecciona un rango de fechas',
              suffixIcon: Icon(Icons.date_range),
              border: OutlineInputBorder(),
            ),
          ),
        ),

        tarjetaFormulario(
          titulo: 'Hora de la reseña',
          child: TextField(
            controller: horaController,
            readOnly: true,
            onTap: seleccionarHora,
            decoration: const InputDecoration(
              hintText: 'Selecciona una hora',
              suffixIcon: Icon(Icons.access_time),
              border: OutlineInputBorder(),
            ),
          ),
        ),

        tarjetaFormulario(
          titulo: 'Etiquetas del libro',
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: etiquetas.map((texto) {
              return InputChip(
                label: Text(texto),
                avatar: const Icon(Icons.local_offer_rounded, size: 18),
                onDeleted: () {},
              );
            }).toList(),
          ),
        ),

        tarjetaFormulario(
          titulo: 'Estado del libro',
          child: Wrap(
            spacing: 8,
            children: estados.map((estado) {
              return ChoiceChip(
                label: Text(estado),
                selected: estadoLibro == estado,
                selectedColor: AppColors.rosa,
                onSelected: (value) {
                  setState(() {
                    estadoLibro = estado;
                  });
                },
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget columnaDos() {
    return Column(
      children: [
        tarjetaFormulario(
          titulo: 'Recomendar libro',
          child: SwitchListTile(
            title: const Text('¿Recomendarías este libro?'),
            value: recomienda,
            activeColor: AppColors.rosa,
            onChanged: (value) {
              setState(() {
                recomienda = value;
              });
            },
          ),
        ),

        tarjetaFormulario(
          titulo: 'Comentario o reseña',
          child: TextField(
            controller: comentarioController,
            maxLines: 4,
            maxLength: 200,
            decoration: const InputDecoration(
              hintText: 'Escribe tu opinión del libro...',
              border: OutlineInputBorder(),
            ),
          ),
        ),

        tarjetaFormulario(
          titulo: 'Género del libro',
          child: DropdownButtonFormField<String>(
            value: generoSeleccionado,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
            items: generos.map((genero) {
              return DropdownMenuItem(
                value: genero,
                child: Text(genero),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                generoSeleccionado = value!;
              });
            },
          ),
        ),

        tarjetaFormulario(
          titulo: 'Calificación',
          child: Column(
            children: [
              RadioListTile<String>(
                title: const Text('5 estrellas'),
                value: '5 estrellas',
                groupValue: calificacion,
                onChanged: (value) {
                  setState(() {
                    calificacion = value!;
                  });
                },
              ),
              RadioListTile<String>(
                title: const Text('4 estrellas'),
                value: '4 estrellas',
                groupValue: calificacion,
                onChanged: (value) {
                  setState(() {
                    calificacion = value!;
                  });
                },
              ),
              RadioListTile<String>(
                title: const Text('3 estrellas'),
                value: '3 estrellas',
                groupValue: calificacion,
                onChanged: (value) {
                  setState(() {
                    calificacion = value!;
                  });
                },
              ),
            ],
          ),
        ),

        tarjetaFormulario(
          titulo: 'Emociones que dejó el libro',
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: emociones.map((emocion) {
              return FilterChip(
                label: Text(emocion),
                selected: emocionesSeleccionadas.contains(emocion),
                selectedColor: AppColors.celeste,
                onSelected: (value) {
                  setState(() {
                    if (value) {
                      emocionesSeleccionadas.add(emocion);
                    } else {
                      emocionesSeleccionadas.remove(emocion);
                    }
                  });
                },
              );
            }).toList(),
          ),
        ),

        SizedBox(
          width: double.infinity,
          height: 55,
          child: ElevatedButton.icon(
            onPressed: guardarResena,
            icon: const Icon(Icons.save_rounded),
            label: const Text('GUARDAR RESEÑA'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.rosa,
              foregroundColor: AppColors.texto,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(22),
              ),
            ),
          ),
        ),
      ],
    );
  }
}