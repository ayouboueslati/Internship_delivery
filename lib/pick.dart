import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PickScreen extends StatefulWidget {
  @override
  _PickScreenState createState() => _PickScreenState();
}

class _PickScreenState extends State<PickScreen> {
  final ImagePicker _imagePicker = ImagePicker();
  List<File?> _pickedImages = List.generate(4, (_) => null);

  Future<void> _pickImage(int index) async {
    final XFile? pickedImage = await _imagePicker.pickImage(
      source: ImageSource.gallery, // You can also use ImageSource.camera here
    );

    if (pickedImage != null) {
      setState(() {
        _pickedImages[index] = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: 4,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => _pickImage(index),
            child: Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.grey[300],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.camera_alt,
                    size: 38,
                    color: Colors.grey[600],
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Pick Image $index',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  _pickedImages[index] != null
                      ? Image.file(_pickedImages[index]!)
                      : SizedBox.shrink(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
