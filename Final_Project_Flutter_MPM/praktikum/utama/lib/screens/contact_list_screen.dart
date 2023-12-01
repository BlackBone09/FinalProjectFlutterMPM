import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'contact.dart';
import 'contact_provider.dart';
import 'contact_form_screen.dart';

class ContactListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact List'),
      ),
      body: Consumer<ContactProvider>(
        builder: (context, contactProvider, child) {
          final contacts = contactProvider.contacts;
          return ListView.builder(
            itemCount: contacts.length,
            itemBuilder: (context, index) {
              final contact = contacts[index];
              
              final iconFile = contact.iconPath.isNotEmpty ? File(contact.iconPath) : null;
              final iconExists = iconFile != null && iconFile.existsSync();
              
              return Container(
                color: stringToColor(contact.backgroundColor),
                child: ListTile(
                  leading: ClipOval(
                    child: iconExists
                        ? Image.file(
                            iconFile!,
                            width: 40.0,
                            height: 40.0,
                            fit: BoxFit.cover,
                          )
                        : Icon(Icons.person),
                  ),
                  title: Text(contact.name),
                  subtitle: Text(contact.email),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ContactFormScreen(contact: contact),
                      ),
                    );
                  },
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Delete Contact'),
                          content: Text('Are you sure you want to delete ${contact.name}?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                contactProvider.deleteContact(contact.id);
                                Navigator.pop(context);
                              },
                              child: Text('Delete'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ContactFormScreen(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ContactProvider(),
      child: MaterialApp(
        title: 'Contact List',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ContactListScreen(),
      ),
    ),
  );
}
