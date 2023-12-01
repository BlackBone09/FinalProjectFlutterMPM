import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:utama/screens/contact_list_screen.dart';
import 'package:utama/screens/contact_provider.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('Contact List Screen UI Test', (WidgetTester tester) async {
    // Render ContactListScreen with necessary providers
    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider(
          create: (context) => ContactProvider(),
          child: ContactListScreen(),
        ),
      ),
    );

    // Check if the "Contact List" text is present
    expect(find.text('Contact List'), findsOneWidget);
  });
}
