import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'contact.dart';

class ContactProvider with ChangeNotifier {
  List<Contact> _contacts = [];

  ContactProvider() {
    _loadContacts();
  }

  List<Contact> get contacts => _contacts;

  void _loadContacts() async {
    final prefs = await SharedPreferences.getInstance();
    final contactsData = prefs.getStringList('contacts') ?? [];
    _contacts = contactsData.map((e) => Contact.fromMap(jsonDecode(e))).toList();
    notifyListeners();
  }

  void _saveContacts() async {
    final prefs = await SharedPreferences.getInstance();
    final contactsData = _contacts.map((e) => jsonEncode(e.toMap())).toList();
    prefs.setStringList('contacts', contactsData);
  }

  void addContact(Contact contact) {
    _contacts.add(contact);
    _saveContacts();
    notifyListeners();
  }

  void updateContact(Contact contact) {
    final index = _contacts.indexWhere((e) => e.id == contact.id);
    if (index != -1) {
      _contacts[index] = contact;
      _saveContacts();
      notifyListeners();
    }
  }

  void deleteContact(String id) {
    _contacts.removeWhere((contact) => contact.id == id);
    notifyListeners();
  }
}
