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
        body: Stack(children: [
      Positioned(
          child: Container(
        width: double.maxFinite,
        height: Dimensions.height40,
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage(
              '/home/santiago/Documents/WorkSpace/JRC-Api-Front/assets/images/logo.png'),
        )),
      )),
      const Align(
        alignment: Alignment.center,
      ),
      Positioned(
          width: Dimensions.screenWidth,
          top: Dimensions.height60,
          height: Dimensions.height50,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: Dimensions.width10,
              vertical: Dimensions.height5,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: Colors.black,
            ),
            child: Column(
              children: [
                Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.only(
                          bottom: Dimensions.screenHeight * 0.03),
                    )),
                Padding(
                  padding: EdgeInsets.only(bottom: Dimensions.height10),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //login button
                      ElevatedButton(
                        onPressed: () {
                          //Get.offAllNamed('/ingresar');
                        },
                        style: ElevatedButton.styleFrom(
                          primary: const Color.fromARGB(1000, 198, 169, 95),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          minimumSize:
                              Size(Dimensions.width90, Dimensions.buttonHeight),
                        ),
                        child: Text("Sing In",
                            style: GoogleFonts.kodchasan(
                              color: Colors.black,
                              fontSize: 15,
                            )),
                      ),
                      SizedBox(height: 20),
                      // registrer button
                      ElevatedButton(
                        onPressed: () {
                          //Get.offAllNamed('/registrar');
                        },
                        style: ElevatedButton.styleFrom(
                            primary: Colors.black,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                                side: const BorderSide(
                                    color: Color.fromARGB(1000, 198, 169, 95),
                                    width: 1.5)),
                            minimumSize: Size(
                                Dimensions.width90, Dimensions.buttonHeight)),
                        child: Text("Sing Up",
                            style: GoogleFonts.kodchasan(
                              color: const Color.fromARGB(1000, 198, 169, 95),
                              fontSize: 15,
                            )),
                      )
                    ],
                  ),
                )
              ],
            ),
          ))
    ]));
  }
}
