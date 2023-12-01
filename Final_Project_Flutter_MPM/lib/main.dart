import 'package:flutter/material.dart'; // Material
import 'package:provider/provider.dart'; // Package Provider 
import 'screens/contact_provider.dart'; // Import ContactProvider
import 'screens/contact_list_screen.dart'; // Import the ContactListScreen
import 'screens/home_screen.dart'; // Import the HomeScreen
import 'screens/gallery_screen.dart'; // Import the GalleryScreen
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ContactProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Kontak dan Galeri',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(), // Set HomeScreen as the starting page
      routes: {
        '/contactList': (context) => ContactListScreen(),
        '/gallery': (context) => GalleryScreen(),
      },
    );
  }
}
