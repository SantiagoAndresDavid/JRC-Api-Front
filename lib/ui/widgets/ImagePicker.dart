import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerWidget extends StatefulWidget {
  final void Function(File? image)? onImageSelected;
  final File? initialImageFile;
  final String? initialImageUrl;

  ImagePickerWidget(
      {this.onImageSelected, this.initialImageFile, this.initialImageUrl});

  @override
  _ImagePickerWidgetState createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  late File? _imageFile;
  String? _imageFileUrl;

  @override
  void initState() {
    super.initState();
    _imageFile = widget.initialImageFile;
    _imageFileUrl = widget.initialImageUrl;
  }

  Future<void> _selectImage() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.getImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      final imageFile = File(pickedFile.path);
      setState(() {
        _imageFile = imageFile;
        _imageFileUrl =
            null; // Clear the image URL if an image file is selected
      });
      if (widget.onImageSelected != null) {
        widget.onImageSelected!(imageFile);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: _selectImage,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color.fromARGB(1000, 198, 169, 95),
                width: 3,
              ),
            ),
            width: 150,
            height: 150,
            child: _imageFile != null
                ? Image.file(
                    _imageFile!,
                    fit: BoxFit.cover,
                  )
                : _imageFileUrl != null
                    ? Image.network(
                        _imageFileUrl!,
                        fit: BoxFit.cover,
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.add_a_photo,
                            size: 60,
                            color: Colors.grey,
                          ),
                          Text(
                            'Agregar foto',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
