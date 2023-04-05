import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/dimensions.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(child: Container(
            width: double.maxFinite,
            height: Dimensions.height40,
            decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage('/home/santiago/Documents/WorkSpace/JRC-Api-Front/assets/images/logo.png'))
            ),
          ))
        ],
      ),
    );
  }
}