import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:jrc_front/domain/clothes.dart';
import 'package:jrc_front/ui/pages/auth/signUp.dart';
import 'package:firebase_storage/firebase_storage.dart' as fs;

class AddRequest {
  static final fs.FirebaseStorage storage = fs.FirebaseStorage.instance;
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  static UploadTask? uploadTask;

  static Future<String> saveClothes(Clothes clothes) async {
    var url = await uploadFile(clothes.model, clothes.image);

    /*proyecto['anexos'] = url.toString();

    await _db
        .collection('Proyectos')
        .doc(proyecto['Campo'])
        .set(proyecto)
        .catchError((e) {});*/
    return "se guardo con exito";
  }

  static Future<dynamic> uploadFile(String model, File?selectedImage) async {
    var r;
    final path = 'Image/$model';

    try {
      final storage = FirebaseStorage.instance;
      final ref = storage.ref().child(path);
      final uploadTask = ref.putFile(selectedImage!);
      final snapshot = await uploadTask.whenComplete(() {});
      final urlDownload = await snapshot.ref.getDownloadURL();
      r = urlDownload;
      log('Link de descarga: $urlDownload');
    } catch (error) {
      if (error is FirebaseException) {
        log('Error al subir la imagen: ${error.message}');
      } else {
        log('Error al subir la imagen: $error');
      }
    }
    return r;
  }
}
