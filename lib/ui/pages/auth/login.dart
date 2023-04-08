import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/dimensions.dart';
import '../../widgets/appIcon.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
                      '/home/santiago/Documents/WorkSpace/JRC-Api-Front/assets/images/logo.png'
                  ),
                )
              )
            )
          ),
          Positioned(
            top: Dimensions.height5,
            left: Dimensions.width5,
            child: IconButton(
              icon: const AppIcon(
                iconData: Icons.arrow_back_ios,
                iconColor: Color.fromARGB(255, 202, 209, 209)),
              onPressed: () {
                Get.offAllNamed('/home');
              },
            )
          )
        ],
      ),
    );
  }
}
