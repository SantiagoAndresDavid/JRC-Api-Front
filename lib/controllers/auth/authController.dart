import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../data/services/auth/authRequest.dart';

class AuthController extends GetxController {
  
  Future<String> LoginController(String email, String password) async {
    try {
      UserCredential user = await AuthRequest.SingIn(email, password);
      return 'Iniciado con exito';
    } on FirebaseAuthException catch (e) {
      return e.toString();
    }
  }

  Future<String> SingUpController(String email, String password) async {
    try {
      UserCredential user = await AuthRequest.SingUp(email, password);
      return 'Registrado con exito';
    } on FirebaseAuthException catch (e) {
      return e.toString();
    }
  }

}
