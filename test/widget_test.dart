import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_application_1/main.dart';

void main() {
  testWidgets('Vérification du chargement de G-Store ESPRIT avec ListView', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Vérifier la présence de l'AppBar et du titre
    expect(find.text('G-Store ESPRIT'), findsOneWidget);

    // Vérifier la présence du ListView
    expect(find.byType(ListView), findsOneWidget);

    // Vérifier le basculement vers Films
    await tester.tap(find.byIcon(Icons.movie));
    await tester.pump();

    // Vérifier la présence du titre Ciné ESPRIT
    expect(find.text('Ciné ESPRIT'), findsOneWidget);
  });
}
