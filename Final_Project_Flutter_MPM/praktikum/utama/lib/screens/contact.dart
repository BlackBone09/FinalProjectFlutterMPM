import 'package:flutter/material.dart';

class Contact {
  String id;
  String name;
  String email;
  String phoneNumber;
  DateTime birthday;
  String backgroundColor; // Store Color as String
  String iconPath;

  Contact({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.birthday,
    required this.backgroundColor, // Receive Color as String
    required this.iconPath,
  });

  // Convert Map to Contact when retrieving a Contact instance
  factory Contact.fromMap(Map<String, dynamic> map) {
    return Contact(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      phoneNumber: map['phoneNumber'],
      birthday: DateTime.parse(map['birthday']),
      backgroundColor: map['backgroundColor'], // Receive Color as String
      iconPath: map['iconPath'],
    );
  }

  // Convert Contact to Map when creating a Contact instance
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'birthday': birthday.toIso8601String(),
      'backgroundColor': backgroundColor, // Store Color as String
      'iconPath': iconPath,
    };
  }
}

// Utility to convert Color to String
String colorToString(Color color) {
  return '#${color.value.toRadixString(16).padLeft(8, '0')}';
}

// Utility to convert String to Color
Color stringToColor(String colorString) {
  return Color(int.parse(colorString.substring(1), radix: 16));
}
