import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jrc_front/controllers/auth/authController.dart';

import '../../utils/dimensions.dart';
import '../../widgets/Input.dart';
import '../../widgets/appIcon.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isKeyboardVisible = false;

  @override
  void initState() {
    super.initState();
    KeyboardVisibilityController().onChange.listen((bool visible) {
      setState(() {
        isKeyboardVisible = visible;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
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
              height: Dimensions.height50,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(25)),
                image: DecorationImage(
                  image: AssetImage('assets/images/logo.png'),
                ),
              ),
            ),
          ),
          Positioned(
            top: Dimensions.height5,
            left: Dimensions.width5,
            height: Dimensions.height10,
            child: IconButton(
              icon: const AppIcon(
                iconData: Icons.arrow_back_ios,
                iconColor: Color.fromARGB(255, 202, 209, 209),
              ),
              onPressed: () {
                Get.offAllNamed('/home');
              },
            ),
          ),
          Positioned(
            width: Dimensions.screenWidth,
            top: isKeyboardVisible ? Dimensions.height30 : Dimensions.height65,
            height: Dimensions.width75,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: Dimensions.width10,
                vertical: Dimensions.height5,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
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
                              emailController.text, passwordController.text)
                          .then((value) {
                        if (value == 'Iniciado con exito') {
                          Get.offAllNamed('/menu');
                        }
                      }).catchError((e) {
                        Get.snackbar(
                          'Validacion de Usuarios',
                          'Datos Invalidos',
                          snackPosition: SnackPosition.TOP,
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                          duration: Duration(seconds: 5),
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
                    child: Text(
                      "Sign In",
                      style: GoogleFonts.robotoFlex(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
