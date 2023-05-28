import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditItemDialog extends StatelessWidget {
  final dynamic clothesItem;

  const EditItemDialog({Key? key, required this.clothesItem}) : super(key: key);

  void editItemAction() {
    // Implementa tu lógica de edición personalizada aquí
    Get.snackbar(
      'Validacion de datos',
      'Se ha editado con éxito',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Editar elemento'),
      content: Text('Aquí puedes realizar la acción de edición'),
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
