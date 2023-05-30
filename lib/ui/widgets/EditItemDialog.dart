import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jrc_front/ui/widgets/ImagePicker.dart';

import 'Input.dart';
import 'colorPicker.dart';

class EditItemDialog extends StatefulWidget {
  final dynamic clothesItem;

  const EditItemDialog({Key? key, required this.clothesItem}) : super(key: key);

  @override
  _EditItemDialogState createState() => _EditItemDialogState();
}

class _EditItemDialogState extends State<EditItemDialog> {
  bool isLoading = true;
  late TextEditingController modelController;
  late TextEditingController sizeController;
  late TextEditingController availabilityController;
  late TextEditingController supplierController;
  late Color currentColor = Colors.red;
  late File? selectedImage;

  @override
  void initState() {
    super.initState();
    modelController = TextEditingController(text: widget.clothesItem['model']);
    sizeController = TextEditingController(text: widget.clothesItem['size']);
    availabilityController =
        TextEditingController(text: widget.clothesItem['availability']);
    supplierController =
        TextEditingController(text: widget.clothesItem['supplier']);
    currentColor = Color(int.parse(widget.clothesItem['color']));
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  void editItemAction() {
    Get.snackbar(
      'Validacion de datos',
      'Se ha editado con éxito',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
    );
  }

  void changeColor(Color color) {
    setState(() => currentColor = color);
  }

  void _onImageSelected(File image) {
    setState(() {
      selectedImage = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Editar elemento'),
      content: SingleChildScrollView(
        child: SizedBox(
          height: 560,
          width: 350, // Tamaño personalizado
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
              const SizedBox(height: 16), // Espacio entre los campos de entrada
              Input(
                false,
                sizeController,
                "Talla",
                const EdgeInsets.all(0),
                const EdgeInsets.only(bottom: 8),
                const Color.fromARGB(255, 197, 197, 197),
                Colors.black,
              ),
              const SizedBox(height: 16), // Espacio entre los campos de entrada
              Input(
                false,
                availabilityController,
                "Disponibilidad",
                const EdgeInsets.all(0),
                const EdgeInsets.only(bottom: 8),
                const Color.fromARGB(255, 197, 197, 197),
                Colors.black,
              ),
              const SizedBox(height: 16), // Espacio entre los campos de entrada
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
                child: ImagePickerWidget(onImageSelected: _onImageSelected),
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
          onPressed: () {
            // Realiza la acción de edición deseada
            editItemAction();
            Navigator.of(context).pop();
          },
          child: Text('Confirmar'),
        ),
      ],
    );
  }
}
