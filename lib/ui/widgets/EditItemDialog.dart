import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:jrc_front/ui/widgets/ImagePicker.dart';
import '../../controllers/clothes/clothesController.dart';
import '../../domain/clothes.dart';
import 'Input.dart';
import 'colorPicker.dart';

class EditItemDialog extends StatefulWidget {
  final dynamic clothesItem;
  final void Function(bool) onConfirm;

  const EditItemDialog(
      {Key? key, required this.clothesItem, required this.onConfirm})
      : super(key: key);

  @override
  _EditItemDialogState createState() => _EditItemDialogState();
}

class _EditItemDialogState extends State<EditItemDialog> {
  bool isLoading = false;
  late TextEditingController modelController;
  late TextEditingController sizeController;
  late TextEditingController availabilityController;
  late TextEditingController supplierController;
  late Color currentColor;
  File? selectedImage;
  late ClothesController controller;

  @override
  void initState() {
    super.initState();
    controller = ClothesController();
    modelController = TextEditingController(text: widget.clothesItem['model']);
    sizeController = TextEditingController(text: widget.clothesItem['size']);
    availabilityController =
        TextEditingController(text: widget.clothesItem['availability']);
    supplierController =
        TextEditingController(text: widget.clothesItem['supplier']);
    currentColor = Color(int.parse(widget.clothesItem['color']));
    selectedImage = null;

    downloadImage(widget.clothesItem['image']).then((file) {
      setState(() {
        selectedImage = file;
      });
    });
  }

  Future<File> downloadImage(String url) async {
    final response = await http.get(Uri.parse(url));
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/image.jpg';
    final file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return file;
  }

  void changeColor(Color color) {
    setState(() => currentColor = color);
  }

  void _onImageSelected(File? image) {
    setState(() {
      selectedImage = image;
    });
  }

  void updateClothes() async {
    setState(() {
      isLoading = true;
    });

    Clothes clothes = Clothes(
      id: widget.clothesItem['id'],
      model: modelController.text,
      size: sizeController.text,
      availability: availabilityController.text,
      supplier: supplierController.text,
      color: "0x${currentColor.value.toRadixString(16).padLeft(8, '0')}",
      image: selectedImage,
    );

    String value = await controller.UpdateClothes(clothes);

    setState(() {
      isLoading = false;
    });

    if (value == 'Se ha Actualizado Correctamente') {
      Navigator.of(context).pop();
      widget.onConfirm(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Editar elemento'),
      content: SingleChildScrollView(
        child: SizedBox(
          height: 560,
          width: 350,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Input(
                false,
                modelController,
                "Modelo",
                const EdgeInsets.all(0),
                const EdgeInsets.only(bottom: 8),
                const Color.fromARGB(255, 197, 197, 197),
                Colors.black,
              ),
              const SizedBox(height: 16),
              Input(
                false,
                sizeController,
                "Talla",
                const EdgeInsets.all(0),
                const EdgeInsets.only(bottom: 8),
                const Color.fromARGB(255, 197, 197, 197),
                Colors.black,
              ),
              const SizedBox(height: 16),
              Input(
                false,
                availabilityController,
                "Disponibilidad",
                const EdgeInsets.all(0),
                const EdgeInsets.only(bottom: 8),
                const Color.fromARGB(255, 197, 197, 197),
                Colors.black,
              ),
              const SizedBox(height: 16),
              Input(
                false,
                supplierController,
                "Proveedor",
                const EdgeInsets.all(0),
                const EdgeInsets.only(bottom: 8),
                const Color.fromARGB(255, 197, 197, 197),
                Colors.black,
              ),
              SizedBox(
                width: 180,
                child: ColorPickerWidget(
                  currentColor: currentColor,
                  onColorChanged: changeColor,
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: 160,
                height: 170,
                child: ImagePickerWidget(
                    onImageSelected: _onImageSelected,
                    initialImageFile: selectedImage),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancelar'),
        ),
        TextButton(
          onPressed: isLoading ? null : updateClothes,
          child: isLoading ? CircularProgressIndicator() : Text('Confirmar'),
        ),
      ],
    );
  }
}
