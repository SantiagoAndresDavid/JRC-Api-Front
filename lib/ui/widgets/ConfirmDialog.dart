import 'package:flutter/material.dart';

class ConfirmDialog extends StatelessWidget {
  final Function() onConfirm;

  const ConfirmDialog({required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Confirmar eliminación'),
      content: Text('¿Estás seguro de que deseas eliminar este elemento?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancelar'),
        ),
        TextButton(
          onPressed: onConfirm,
          child: Text('Aceptar'),
        ),
      ],
    );
  }
}
