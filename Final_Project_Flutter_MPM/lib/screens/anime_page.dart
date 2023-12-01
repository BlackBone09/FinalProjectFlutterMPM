import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'config.dart';
import 'image_display_page.dart'; // Import the ImageDisplayPage

class AnimePage extends StatefulWidget {
  @override
  _AnimePageState createState() => _AnimePageState();
}

class _AnimePageState extends State<AnimePage> {
  final apiKey = Config.rapidApiKey;
  final apiUrl = 'https://any-anime.p.rapidapi.com/v1/anime/png/5/';

  List<String> imageUrls = [];

  Future<void> fetchImages() async {
    try {
      final response = await http.get(Uri.parse(apiUrl), headers: {
        'X-RapidAPI-Key': apiKey,
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['images'] != null && data['images'].isNotEmpty) {
          setState(() {
            imageUrls = List<String>.from(data['images']);
          });
          _navigateToImageDisplayPage(); // Navigate to ImageDisplayPage
        } else {
          Fluttertoast.showToast(
            msg: 'No images found',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
          );
        }
      } else {
        Fluttertoast.showToast(
          msg: 'Failed to fetch images',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Error: $e',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  void _navigateToImageDisplayPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ImageDisplayPage(imageUrls: imageUrls),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Anime Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await fetchImages();
          },
          child: Text('Generate Images'),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: AnimePage(),
  ));
}
