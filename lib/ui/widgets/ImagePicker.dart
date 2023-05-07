import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerWidget extends StatefulWidget {
  final void Function(File image) onImageSelected;

  ImagePickerWidget({required this.onImageSelected});

  @override
  _ImagePickerWidgetState createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  File? _imageFile;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color.fromARGB(1000, 198, 169, 95),
                  width: 3,
                ),
              ),
              child: IconButton(
                onPressed: () async {
                  final imagePicker = ImagePicker();
                  final pickedFile = await imagePicker.getImage(
                    source: ImageSource.gallery,
                  );

                  if (pickedFile != null) {
                    final imageFile = File(pickedFile.path);
                    setState(() {
                      _imageFile = imageFile;
                    });
                    widget.onImageSelected(imageFile);
                  }
                },
                icon: _imageFile == null
                    ? Icon(Icons.add_a_photo, size: 60)
                    : SizedBox(),
                iconSize: 60,
                color: const Color.fromARGB(1000, 198, 169, 95),
              ),
            ),
            if (_imageFile != null)
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromARGB(1000, 198, 169, 95),
                    width: 3,
                  ),
                ),
                child: SizedBox(
                  height: 150, // Establece una altura fija para el contenedor
                  width: 150, // Establece una anchura fija para el contenedor
                  child: Image.file(
                    _imageFile!,
                    fit: BoxFit
                        .cover, // Ajusta la imagen para recortarla al tamaño del contenedor
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
