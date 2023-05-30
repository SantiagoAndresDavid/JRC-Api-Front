import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ClothesDetailsDialog extends StatelessWidget {
  final dynamic clothesItem;

  const ClothesDetailsDialog({required this.clothesItem});

  @override
  Widget build(BuildContext context) {
    TextStyle titleStyle = GoogleFonts.roboto(
      color: const Color.fromARGB(1000, 198, 169, 95),
      fontSize: 25,
      fontWeight: FontWeight.w400,
    );

    TextStyle resultStyle = GoogleFonts.roboto(
      color: Colors.black,
      fontSize: 18,
      fontWeight: FontWeight.w400,
    );

    Widget buildDivider() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Row(
          children: [
            Expanded(
              child: Divider(
                color: Colors.grey[300],
                thickness: 1,
              ),
            ),
            const SizedBox(width: 5),
            Text(
              '• • • •',
              style: TextStyle(
                color: Colors.grey[300],
                fontSize: 16,
                fontWeight: FontWeight.w200,
              ),
            ),
            const SizedBox(width: 5),
            Expanded(
              child: Divider(
                color: Colors.grey[300],
                thickness: 1,
              ),
            ),
          ],
        ),
      );
    }

    return Dialog(
      insetPadding: EdgeInsets.zero,
      child: Container(
        constraints: const BoxConstraints(
          maxWidth: 355.0,
          maxHeight: 640.0,
        ),
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              fit: FlexFit.tight,
              child: Container(
                padding: const EdgeInsets.only(bottom: 20),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                  color: Color.fromARGB(1000, 240, 240, 240),
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      color: Colors.black,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    Expanded(
                      child: Text(
                        'Detalles de la Prenda',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: RichText(
                  text: TextSpan(
                    text: 'Modelo: ',
                    style: titleStyle,
                    children: [
                      TextSpan(text: clothesItem['model'], style: resultStyle),
                    ],
                  ),
                ),
              ),
            ),
            buildDivider(),
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: RichText(
                  text: TextSpan(
                    text: 'Talla: ',
                    style: titleStyle,
                    children: [
                      TextSpan(text: clothesItem['size'], style: resultStyle),
                    ],
                  ),
                ),
              ),
            ),
            buildDivider(),
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: RichText(
                  text: TextSpan(
                    text: 'Disponibilidad: ',
                    style: titleStyle,
                    children: [
                      TextSpan(
                        text: clothesItem['availability'],
                        style: resultStyle,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            buildDivider(),
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: RichText(
                  text: TextSpan(
                    text: 'Proveedor: ',
                    style: titleStyle,
                    children: [
                      TextSpan(
                        text: clothesItem['supplier'],
                        style: resultStyle,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            buildDivider(),
            Expanded(
              child: Row(
                children: [
                  Text(
                    'Color: ',
                    style: titleStyle,
                  ),
                  const SizedBox(width: 10),
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(int.parse(clothesItem['color'])),
                    ),
                  ),
                ],
              ),
            ),
            buildDivider(),
            Container(
              width: 150,
              height: 180,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2.5),
              ),
              child: Image.network(
                clothesItem['image'],
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
