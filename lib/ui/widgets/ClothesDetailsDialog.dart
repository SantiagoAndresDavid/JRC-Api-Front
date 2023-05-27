import 'package:flutter/material.dart';

class ClothesDetailsDialog extends StatelessWidget {
  final dynamic clothesItem;

  const ClothesDetailsDialog({required this.clothesItem});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 50.0), // Ajusta los márgenes internos del diálogo
      child: SizedBox(
        // Utiliza SizedBox para establecer un tamaño personalizado
        width: 300.0,
        height: 200.0, // Establece el ancho del diálogo
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                color: Colors.black,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            // Contenido del diálogo de detalles
            // Agrega aquí los detalles del elemento seleccionado
            // Puedes usar un Column, ListView o cualquier otro widget para mostrar los detalles
            Text(clothesItem['model']),
          ],
        ),
      ),
    );
  }
}
