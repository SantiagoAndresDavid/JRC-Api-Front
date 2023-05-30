import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ClothesDetailsDialog extends StatelessWidget {
  final dynamic clothesItem;

  const ClothesDetailsDialog({required this.clothesItem});

  @override
  Widget build(BuildContext context) {
    TextStyle titleStyle = GoogleFonts.roboto(
      color: Color.fromARGB(1000, 198, 169, 95),
      fontSize: 30,
      fontWeight: FontWeight.w200,
    );

    TextStyle resultStyle = GoogleFonts.roboto(
      color: Colors.black,
      fontSize: 18,
      fontWeight: FontWeight.w200,
    );

    Widget buildDivider() {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          children: [
            Expanded(
              child: Divider(
                color: Colors.grey[300],
                thickness: 1,
              ),
            ),
            SizedBox(width: 10),
            Text(
              '• • • •',
              style: TextStyle(
                color: Colors.grey[300],
                fontSize: 16,
                fontWeight: FontWeight.w200,
              ),
            ),
            SizedBox(width: 10),
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
        constraints: BoxConstraints(
          maxWidth: 350.0,
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
                padding: EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
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
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
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
            SizedBox(height: 20),
            Row(
              children: [
                Text(
                  'Color: ',
                  style: titleStyle,
                ),
                SizedBox(width: 10),
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xfffae9e8),
                  ),
                ),
              ],
            ),
            buildDivider(),
            SizedBox(height: 20),
            Container(
              width: 150,
              height: 150,
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
