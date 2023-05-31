import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jrc_front/domain/clothes.dart';
import '../../../../controllers/clothes/clothesController.dart';
import '../../../utils/dimensions.dart';
import '../../../widgets/ImagePicker.dart';
import '../../../widgets/Input.dart';
import '../../../widgets/colorPicker.dart';

class Add extends StatefulWidget {
  const Add({Key? key}) : super(key: key);

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  TextEditingController modelController = TextEditingController();
  TextEditingController sizeController = TextEditingController();
  TextEditingController availabilityController = TextEditingController();
  TextEditingController providerController = TextEditingController();
  ClothesController addController = ClothesController();
  Color currentColor = Colors.red;
  File? selectedImage;
  bool _isLoading = false;

  void changeColor(Color color) {
    setState(() => currentColor = color);
  }

  void _onImageSelected(File image) {
    setState(() {
      selectedImage = image;
    });
  }

  void _resetFields() {
    modelController.clear();
    sizeController.clear();
    availabilityController.clear();
    providerController.clear();
    selectedImage = null;
    setState(() {
      _isLoading = false;
    });
  }

String generateRandomString(int len) {
  var r = Random();
  const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  return List.generate(len, (index) => _chars[r.nextInt(_chars.length)]).join();
}
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 30),
        const Text(
          'Agregar Nuevos Productos',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(1000, 198, 169, 95),
          ),
        ),
        const SizedBox(height: 40),
        SizedBox(
          width: 350,
          child: Input(
            false,
            modelController,
            "Modelo",
            const EdgeInsets.all(0),
            const EdgeInsets.only(bottom: 8),
            const Color.fromARGB(255, 197, 197, 197),
            Colors.grey.shade700,
          ),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            const SizedBox(width: 15),
            SizedBox(
              width: 100,
              child: Input(
                false,
                sizeController,
                "Talla ",
                const EdgeInsets.all(0),
                const EdgeInsets.only(bottom: 8),
                const Color.fromARGB(255, 197, 197, 197),
                Colors.grey.shade700,
              ),
            ),
            const SizedBox(width: 20),
            SizedBox(
              width: 230,
              child: Input(
                false,
                availabilityController,
                "Disponibilidad",
                const EdgeInsets.all(0),
                const EdgeInsets.only(bottom: 8),
                const Color.fromARGB(255, 197, 197, 197),
                Colors.grey.shade700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: 350,
          child: Input(
            false,
            providerController,
            "Proveedor",
            const EdgeInsets.all(0),
            const EdgeInsets.only(bottom: 8),
            const Color.fromARGB(255, 197, 197, 197),
            Colors.grey.shade700,
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 200,
          child: Row(
            children: [
              const SizedBox(width: 15),
              SizedBox(
                width: 180,
                child: ColorPickerWidget(
                  currentColor: currentColor,
                  onColorChanged: changeColor,
                ),
              ),
              const SizedBox(width: 10),
              SizedBox(
                width: 160,
                child: ImagePickerWidget(onImageSelected: _onImageSelected),
              ),
            ],
          ),
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _isLoading = true;
            });

            Clothes clothes = Clothes(
              id: generateRandomString(15),
              model: modelController.text,
              size: sizeController.text,
              availability: availabilityController.text,
              supplier: providerController.text,
              color:
                  "0x${currentColor.value.toRadixString(16).padLeft(8, '0')}",
              image: selectedImage,
            );
            addController.SaveClothes(clothes).then((value) {
              if (value == 'Se ha Registrado Correctamente') {
                Get.snackbar(
                  'Validacion de datos',
                  'Se ha Registrado Correctamente',
                  snackPosition: SnackPosition.TOP,
                  backgroundColor: Colors.green,
                  colorText: Colors.white,
                  duration: const Duration(seconds: 3),
                );

                _resetFields(); // Reiniciar los campos después de guardar correctamente
              } else {
                Get.snackbar(
                  'Validacion de datos',
                  'No se ha Registrado correctamente',
                  snackPosition: SnackPosition.TOP,
                  backgroundColor: Colors.red,
                  colorText: Colors.white,
                  duration: const Duration(seconds: 3),
                );
                setState(() {
                  _isLoading = false;
                });
              }
            });
          },
          style: ElevatedButton.styleFrom(
            primary: const Color.fromARGB(1000, 198, 169, 95),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(50)),
            ),
            minimumSize: Size(Dimensions.width90, Dimensions.buttonheight2),
          ),
          child: _isLoading
              ? const CircularProgressIndicator() // Mostrar la barra de progreso
              : Text(
                  "Guardar",
                  style: GoogleFonts.robotoFlex(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
        ),
      ],
    );
  }
}
