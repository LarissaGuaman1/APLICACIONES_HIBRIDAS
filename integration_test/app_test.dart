import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:login_app/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Login, ingreso al sistema y apertura del formulario',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Mi Biblioteca Kawaii'), findsOneWidget);

    await tester.enterText(
      find.byType(EditableText).at(0),
      'larissa',
    );

    await tester.enterText(
      find.byType(EditableText).at(1),
      '1234',
    );

    await tester.tap(find.text('INGRESAR'));
    await tester.pumpAndSettle();

    expect(find.text('Bienvenida a tu rincón lector'), findsOneWidget);

    await tester.tap(find.text('Agregar reseña').first);
    await tester.pumpAndSettle();

    expect(find.text('Agregar reseña'), findsOneWidget);
    expect(find.text('Buscar libro'), findsOneWidget);
  });
}