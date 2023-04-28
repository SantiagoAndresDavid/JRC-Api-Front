import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../controllers/auth/authController.dart';
import '../../utils/dimensions.dart';
import '../../widgets/Input.dart';
import '../../widgets/appIcon.dart';

class SingUp extends StatefulWidget {
  const SingUp({super.key});

  @override
  State<SingUp> createState() => _SingUpState();
}

class _SingUpState extends State<SingUp> {
  Widget build(BuildContext context) {
    TextEditingController userController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController emailController = TextEditingController();
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
              height: Dimensions.width90,
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
                      emailController,
                      "Email",
                      const EdgeInsets.all(0),
                      const EdgeInsets.only(bottom: 8),
                      const Color.fromARGB(255, 197, 197, 197),
                      Colors.grey.shade700,
                    ),
                    Input(
                      false,
                      passwordController,
                      "Password",
                      const EdgeInsets.all(0),
                      const EdgeInsets.only(bottom: 8),
                      const Color.fromARGB(255, 197, 197, 197),
                      Colors.grey.shade700,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        String response = '';
                        authController.SingUpController(
                                emailController.text, passwordController.text)
                            .then((value) {
                          if (value == 'Registrado con exito') {
                            Get.showSnackbar(
                              const GetSnackBar(
                                title: 'Validacion de Usuarios',
                                message: 'Usuario registrado correctamente',
                                icon: Icon(Icons.warning),
                                duration: Duration(seconds: 3),
                                backgroundColor: Colors.green,
                                snackPosition: SnackPosition
                                    .TOP, // Configurar el SnackBar para que se muestre desde arriba
                                barBlur:
                                    0, // Eliminar el efecto blur para que el SnackBar sea más legible
                                overlayBlur:
                                    0, // Eliminar el efecto blur del fondo del SnackBar
                                margin: EdgeInsets.only(
                                    top:
                                        0), // Agregar margen superior para el SnackBar
                              ),
                            );
                            Get.offAllNamed('/login');
                          }
                        }).catchError((e) {
                          Get.showSnackbar(
                            GetSnackBar(
                              title: 'Validacion de Usuarios',
                              message: e.toString(),
                              icon: Icon(Icons.warning),
                              duration: Duration(seconds: 5),
                              backgroundColor: Colors.red,
                              snackPosition: SnackPosition
                                  .TOP, // Configurar el SnackBar para que se muestre desde arriba
                              barBlur:
                                  0, // Eliminar el efecto blur para que el SnackBar sea más legible
                              overlayBlur:
                                  0, // Eliminar el efecto blur del fondo del SnackBar
                              margin: const EdgeInsets.only(
                                  top:
                                      0), // Agregar margen superior para el SnackBar
                            ),
                          );
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
