import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:utama/screens/contact_form_screen.dart';

void main() {
  testWidgets('Contact Form Screen Test', (WidgetTester tester) async {
    // Render ContactFormScreen
    await tester.pumpWidget(MaterialApp(home: ContactFormScreen()));

    // Check for the presence of certain widgets and texts
    expect(find.text('Tambahkan Kontak'), findsOneWidget);
    expect(find.text('Nama Lengkap'), findsOneWidget);
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Nomor Telepon'), findsOneWidget);
    expect(find.text('Pilih Warna Latar'), findsOneWidget);
    expect(find.text('Pilih Gambar Ikon'), findsOneWidget);
    expect(find.text('Buka Gallery'), findsOneWidget);
    expect(find.text('Submit'), findsOneWidget);
  });
}
