import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../data/services/auth/authRequest.dart';

class AuthController extends GetxController {
  Future<String> LoginController(String userName, String password) async {
    try {
      UserCredential user = await AuthRequest.SingIn(userName, password);
      return 'Iniciado con exito';
    } on FirebaseAuthException catch (e) {
      return e.toString(); 
    }
  }
}
