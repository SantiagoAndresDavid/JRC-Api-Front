import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jrc_front/controllers/auth/authController.dart';

import '../../utils/dimensions.dart';
import '../../widgets/Input.dart';
import '../../widgets/appIcon.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    TextEditingController userController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    AuthController authController = Get.put(AuthController());
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
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      image: DecorationImage(
                        image: AssetImage(
                            '/home/santiago/Documents/WorkSpace/JRC-Api-Front/assets/images/logo.png'),
                      )))),
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
              )),
          Positioned(
              width: Dimensions.screenWidth,
              top: Dimensions.height30,
              height: Dimensions.width35,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Sing In',
                      style: GoogleFonts.robotoFlex(
                          color: const Color.fromARGB(1000, 198, 169, 95),
                          fontSize: 35,
                          fontWeight: FontWeight.w500))
                ],
              )),
          Positioned(
              width: Dimensions.screenWidth,
              top: Dimensions.height60,
              height: Dimensions.width80,
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.width10,
                    vertical: Dimensions.height5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //add inputs
                    Input(
                      false,
                      userController,
                      "UserName",
                      const EdgeInsets.all(0),
                      const EdgeInsets.only(bottom: 8),
                      const Color.fromARGB(255, 197, 197, 197),
                      Colors.grey.shade700,
                    ),
                    Input(
                      true,
                      passwordController,
                      "Password",
                      const EdgeInsets.all(0),
                      const EdgeInsets.only(bottom: 8),
                      const Color.fromARGB(255, 197, 197, 197),
                      Colors.grey.shade700,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        authController.LoginController(
                                userController.text, passwordController.text)
                            .then((value) {
                          if (value == 'Iniciado con exito') {
                            Get.offAllNamed('/menu');
                          } else {
                            Get.showSnackbar(const GetSnackBar(
                              title: 'Validacion de Usuarios',
                              message: 'Datos Invalidos',
                              icon: Icon(Icons.warning),
                              duration: Duration(seconds: 5),
                              backgroundColor: Colors.red,
                            ));
                          }
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        primary: const Color.fromARGB(1000, 198, 169, 95),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        minimumSize:
                            Size(Dimensions.width90, Dimensions.buttonHeight),
                      ),
                      child: Text("sign in",
                          style: GoogleFonts.robotoFlex(
                            color: Colors.black,
                            fontSize: 15,
                          )),
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
