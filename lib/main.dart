import 'dart:convert'; 

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/platform/platform.dart';
import 'package:jrc_front/ui/App.dart';
  
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GetPlatform.isWeb
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
              apiKey: "AIzaSyBNGV5yqfWjIEOwaWWHo_AynjYy7hr11IE",
              authDomain: "jcr-api.firebaseapp.com",
              projectId: "jcr-api",
              storageBucket: "jcr-api.appspot.com",
              messagingSenderId: "111898350013",
              appId: "1:111898350013:web:a47391dbf80411f43d42d4",
              measurementId: "G-SPNW645W44"))
      : await Firebase.initializeApp();
  runApp(const App());
}
 