import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:utama/screens/home_screen.dart';

void main() {
  testWidgets('Home Screen UI Test', (WidgetTester tester) async {
    // Render HomeScreen
    await tester.pumpWidget(MaterialApp(home: HomeScreen()));

    // Check for the presence of certain texts
    expect(find.text('Aplikasi Kontak dan Galeri'), findsOneWidget);
    expect(find.text('Silahkan gunakan aplikasi ini untuk membuat kontak baru atau melihat galeri'), findsOneWidget);
  });
}
