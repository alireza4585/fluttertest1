import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddPostScreen extends StatefulWidget {
  @override
  _AddPostScreenState createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  TextEditingController captionController = TextEditingController();
  List<File> selectedImages = [];

  Future<void> _selectImages() async {
    final picker = ImagePicker();
    final pickedImages = await picker.pickMultiImage();

    if (pickedImages != null) {
      setState(() {
        selectedImages
            .addAll(pickedImages.map((pickedImage) => File(pickedImage.path)));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Post'),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              // Handle the submission of the post here
              String caption = captionController.text;
              // You can access selectedImages for the selected photos
              print('Caption: $caption');
              for (var imageFile in selectedImages) {
                print('Selected Image: ${imageFile.path}');
                // Upload or process the image as needed
              }
              // Close the screen or navigate to another screen
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(16.0),
                    child: TextFormField(
                      controller: captionController,
                      decoration: InputDecoration(
                        hintText: 'Write a caption...',
                      ),
                      maxLines: null, // Allow multiple lines for captions
                    ),
                  ),
                  if (selectedImages.isNotEmpty)
                    Container(
                      height: 200.0, // Adjust the height as needed
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: selectedImages.length,
                        itemBuilder: (context, index) {
                          final imageFile = selectedImages[index];
                          return Container(
                            margin: EdgeInsets.all(8.0),
                            width: 200.0, // Adjust the width as needed
                            child: Image.file(
                              imageFile,
                              fit: BoxFit.cover,
                            ),
                          );
                        },
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _selectImages,
        child: Icon(Icons.add),
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed
    captionController.dispose();
    super.dispose();
  }
}
