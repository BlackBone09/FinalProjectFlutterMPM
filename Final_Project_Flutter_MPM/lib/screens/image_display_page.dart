import 'package:flutter/material.dart';

class ImageDisplayPage extends StatelessWidget {
  final List<String> imageUrls;

  ImageDisplayPage({required this.imageUrls});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Generated Images'),
      ),
      body: ListView.builder(
        itemCount: imageUrls.length,
        itemBuilder: (context, index) {
          return Image.network(imageUrls[index]);
        },
      ),
    );
  }
}
