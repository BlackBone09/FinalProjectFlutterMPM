import 'package:flutter/material.dart';

class GalleryScreen extends StatelessWidget {
  final List<String> images = List.generate(18, (index) => 'assets/images/image${index + 1}.jpg');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Gallery')),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: images.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => _showImageDetails(context, images[index]),
            child: Image.asset(images[index], fit: BoxFit.cover),
          );
        },
      ),
    );
  }

  void _showImageDetails(BuildContext context, String imagePath) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 180,
                height: 180, // 1:1 ratio
                child: ClipRect(
                  child: Image.asset(imagePath, fit: BoxFit.cover),
                ),
              ),
              SizedBox(height: 20), // Add some spacing between the image and the text
              Text('Buka Gambar?', style: Theme.of(context).textTheme.headline6),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // Close the BottomSheet
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ImageDetailView(imagePath: imagePath),
                        ),
                      );
                    },
                    child: Text('Ya'),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context), // Close the BottomSheet
                    child: Text('Tidak'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class ImageDetailView extends StatelessWidget {
  final String imagePath;

  ImageDetailView({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Detail'),
      ),
      body: Center(
        child: Image.asset(imagePath),
      ),
    );
  }
}
