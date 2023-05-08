import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../../../utils/dimensions.dart';
import '../../../widgets/ImagePicker.dart';
import '../../../widgets/Input.dart';
import '../../../widgets/colorPicker.dart';

class Add extends StatefulWidget {
  const Add({super.key});

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  TextEditingController modelController = TextEditingController();
  TextEditingController sizeController = TextEditingController();
  TextEditingController availabilityController = TextEditingController();
  TextEditingController providerController = TextEditingController();
  Color currentColor = Colors.red;
  File? _selectedImage;

  void changeColor(Color color) {
    setState(() => currentColor = color);
  }

  void _onImageSelected(File image) {
    setState(() {
      _selectedImage = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Aquí puedes agregar cualquier otro widget que quieras
        const Text(
          'Agregar Nuevos Productos',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(1000, 198, 169, 95),
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
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            primary: const Color.fromARGB(1000, 198, 169, 95),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            minimumSize: Size(Dimensions.width90, Dimensions.buttonheight2),
          ),
          child: Text("Guardar",
              style: GoogleFonts.robotoFlex(
                color: Colors.black,
                fontSize: 15,
              )),
        )
      ],
    );
  }
}
