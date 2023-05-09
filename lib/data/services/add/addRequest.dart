import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:jrc_front/ui/pages/auth/signUp.dart';
import 'package:firebase_storage/firebase_storage.dart' as fs;

class AddRequest {
  static final fs.FirebaseStorage storage = fs.FirebaseStorage.instance;
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  static UploadTask? uploadTask;

  static Future<void> saveClothes(Map<String, dynamic> proyecto, String? file,
      String? pickedFileextencion) async {
    var url = '';
    if (file != null) {
      url = await uploadFile(
          file, proyecto['idProyecto'], uploadTask, pickedFileextencion);
    }

    proyecto['anexos'] = url.toString();

    await _db
        .collection('Proyectos')
        .doc(proyecto['Campo'])
        .set(proyecto)
        .catchError((e) {});
  }

  static Future<dynamic> uploadFile(String? file, idProyecto,
      UploadTask? uploadTask, String? pickedFileextencion) async {
    var r;
    final path = 'anexo/$idProyecto.$pickedFileextencion';
    if (file != null) {
      final ref = FirebaseStorage.instance.ref().child(path);
      log(file.toString());
      uploadTask = ref.putString(file);
      final snaphot = await uploadTask.whenComplete(() {});

      final urlDownload = await snaphot.ref.getDownloadURL();
      r = urlDownload;
      log('Link de descarga: $urlDownload');
    }

    return r;
  }

}
