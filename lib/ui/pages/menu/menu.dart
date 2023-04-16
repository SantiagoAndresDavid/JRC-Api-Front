import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/dimensions.dart';
import '../../widgets/Input.dart';
import '../../widgets/appIcon.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              left: 0,
              right: 0,
              child: Container(
                  width: double.maxFinite,
                  height: Dimensions.height40,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage(
                        '/home/santiago/Documents/WorkSpace/JRC-Api-Front/assets/images/logo.png'),
                  )))),
          Positioned(
              width: Dimensions.screenWidth,
              top: Dimensions.height60,
              height: Dimensions.width90,
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.width10,
                    vertical: Dimensions.height5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    //add inputs
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
