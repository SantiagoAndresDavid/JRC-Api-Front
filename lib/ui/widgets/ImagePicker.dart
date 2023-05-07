import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerWidget extends StatelessWidget {
  final void Function(File image) onImageSelected;

  ImagePickerWidget({required this.onImageSelected});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () async {
            final imagePicker = ImagePicker();
            final pickedFile = await imagePicker.getImage(
              source: ImageSource.gallery,
            );

            if (pickedFile != null) {
              onImageSelected(File(pickedFile.path));
            }
          },
          child: Text('Select Image'),
        ),
      ],
    );
  }
}
