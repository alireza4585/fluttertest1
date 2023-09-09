// ignore_for_file: camel_case_types

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class utilwidgets {
  Future<File> uploadImage(String inputsource) async {
    final picker = ImagePicker();
    final XFile? pickImage = await picker.pickImage(
      source:
          inputsource == 'cammera' ? ImageSource.camera : ImageSource.gallery,
    );
    File imagefile = File(pickImage!.path);
    return imagefile;
  }

  Future<void> dialogBuilder(BuildContext context, String message) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Error',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
          ),
          content: Text(message, style: const TextStyle(fontSize: 17)),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
