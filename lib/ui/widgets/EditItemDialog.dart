import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditItemDialog extends StatefulWidget {
  final dynamic clothesItem;

  const EditItemDialog({Key? key, required this.clothesItem}) : super(key: key);

  @override
  _EditItemDialogState createState() => _EditItemDialogState();
}

class _EditItemDialogState extends State<EditItemDialog> {
  bool isLoading = true;

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

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Editar elemento'),
      content: SizedBox(
        height: 500,
        width: 350, // Tamaño personalizado
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 2.0),
                  ),
                  child: isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : Image.network(
                          widget.clothesItem['image'],
                          fit: BoxFit.cover,
                        ),
                ),
              ],
            ),
            // Agrega aquí otros elementos al Column
          ],
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
