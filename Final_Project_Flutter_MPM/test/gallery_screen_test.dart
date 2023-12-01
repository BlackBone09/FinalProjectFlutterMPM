import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:utama/screens/gallery_screen.dart';

void main() {
  testWidgets('Gallery Screen UI Test', (WidgetTester tester) async {
    // Render GalleryScreen
    await tester.pumpWidget(MaterialApp(home: GalleryScreen()));

    // Check for the presence of certain widgets and texts
    expect(find.text('Gallery'), findsOneWidget);
    expect(find.byType(GestureDetector), findsWidgets); // Check for the presence of one or more GestureDetector widgets
  });
}
