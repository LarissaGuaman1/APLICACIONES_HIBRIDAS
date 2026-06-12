import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:login_app/main.dart';

void main() {
  testWidgets('Muestra la pantalla de login', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Mi Biblioteca Kawaii'), findsOneWidget);
    expect(find.text('INGRESAR'), findsOneWidget);
    expect(find.text('¿No tienes cuenta? Regístrate'), findsOneWidget);
  });

  testWidgets('Muestra mensaje si intenta ingresar sin datos',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('INGRESAR'));
    await tester.pump();

    expect(find.text('Ingrese usuario y contraseña'), findsOneWidget);
  });

  testWidgets('Navega al home cuando ingresa usuario y contraseña',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.enterText(find.byType(TextField).at(0), 'larissa');
    await tester.enterText(find.byType(TextField).at(1), '1234');

    await tester.tap(find.text('INGRESAR'));
    await tester.pumpAndSettle();

    expect(find.text('Bienvenida a tu rincón lector'), findsOneWidget);
  });
}