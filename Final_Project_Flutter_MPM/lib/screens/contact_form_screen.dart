import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'contact_provider.dart';
import 'contact.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'gallery_screen.dart'; // Import the GalleryScreen

class ContactFormScreen extends StatefulWidget {
  final Contact? contact;

  ContactFormScreen({this.contact});

  @override
  _ContactFormScreenState createState() => _ContactFormScreenState();
}

class _ContactFormScreenState extends State<ContactFormScreen> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late DateTime _selectedDate;
  late String _selectedColor;
  String _selectedImagePath = '';

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.contact?.name ?? '');
    _emailController = TextEditingController(text: widget.contact?.email ?? '');
    _phoneController =
        TextEditingController(text: widget.contact?.phoneNumber ?? '');
    _selectedDate = widget.contact?.birthday ?? DateTime.now();
    _selectedColor = widget.contact?.backgroundColor ?? colorToString(Colors.white);
    _selectedImagePath = widget.contact?.iconPath ?? '';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambahkan Kontak'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Nama Lengkap'),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(labelText: 'Nomor Telepon'),
            ),
            ElevatedButton(
              onPressed: _pickDate,
              child: Text('Pilih Tanggal Lahir: ${DateFormat.yMd().format(_selectedDate)}'),
            ),
            ElevatedButton(
              onPressed: _pickColor,
              child: Text('Pilih Warna Latar'),
            ),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Pilih Gambar Ikon'),
            ),
            ElevatedButton(
              onPressed: _openGallery,
              child: Text('Buka Gallery'),
            ),
            ElevatedButton(
              onPressed: _submitForm,
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  void _pickDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  void _pickColor() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Pick a color!'),
          content: SingleChildScrollView(
            child: BlockPicker(
              pickerColor: stringToColor(_selectedColor),
              onColorChanged: (color) {
                setState(() {
                  _selectedColor = colorToString(color);
                });
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Got it'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _pickImage() async {
      final result = await FilePicker.platform.pickFiles(type: FileType.image);
      if (result != null) {
        setState(() {
          _selectedImagePath = result.files.single.path!; // Corrected Line
        });
      }
  }

  void _openGallery() async {
    final selectedImagePath = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => GalleryScreen()),
    );
    if (selectedImagePath != null) {
      setState(() {
        _selectedImagePath = selectedImagePath;
      });
    }
  }

  void _submitForm() {
    final contactProvider = Provider.of<ContactProvider>(context, listen: false);
    final contact = Contact(
      id: widget.contact?.id ?? DateTime.now().toString(),
      name: _nameController.text,
      email: _emailController.text,
      phoneNumber: _phoneController.text,
      birthday: _selectedDate,
      backgroundColor: _selectedColor,
      iconPath: _selectedImagePath,
    );
    if (widget.contact == null) {
      contactProvider.addContact(contact);
    } else {
      contactProvider.updateContact(contact);
    }
    Navigator.pop(context);
  }
}
