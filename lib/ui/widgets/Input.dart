import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/dimensions.dart';

class Input extends StatelessWidget {
  //final TextEditingController controller;
  final String text;
  final bool esContrasena;
  Color? colorType;
  EdgeInsets? margin;
  EdgeInsets? padding;
  Color colorText;

  Input(this.esContrasena, /*this.controller*/ this.text, this.margin,
      this.padding, this.colorType, this.colorText,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      margin: margin,
      child: TextField(
          cursorColor: Colors.black,
          obscureText: esContrasena,
          style: TextStyle(color: colorText),
          autofocus: false,
          //controller: controller,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(left: 30),
            filled: true,
            fillColor: colorType,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
            focusColor: colorText,
            labelText: text,
            labelStyle: GoogleFonts.montserrat(
              fontSize: 16,
              color: colorText,
          ),
        )
      ),
    );
  }
}


