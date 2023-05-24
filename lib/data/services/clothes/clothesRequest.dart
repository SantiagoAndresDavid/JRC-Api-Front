import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:jrc_front/domain/clothes.dart';
import 'package:firebase_storage/firebase_storage.dart' as fs;

class ClothesRequest {
  static final fs.FirebaseStorage storage = fs.FirebaseStorage.instance;
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  static UploadTask? uploadTask;

  static Future<String> saveClothes(Clothes clothes) async {
    try {
      var url = await uploadFile(clothes.model, clothes.image);

      var clothesUrl = {
        'model': clothes.model,
        'size': clothes.size,
        'availability': clothes.availability,
        'supplier': clothes.supplier,
        'color': clothes.color,
        'image': url.toString(),
      };

      await _db.collection('Clothes').doc(clothes.model).set(clothesUrl);

      return 'Se ha Registrado Correctamente';
    } catch (e) {
      return 'Error: No se pudo registrar correctamente';
    }
  }

  static Future<dynamic> uploadFile(String model, File? selectedImage) async {
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

  static Future<List<dynamic>> getAllClothes() async {
    List<dynamic> clothesList = [];

    var response = await _db.collection("Clothes").get();
    response.docs.forEach((doc) {
      var clothesUrl = {
        'model': doc.data()['model'],
        'size': doc.data()['size'],
        'availability': doc.data()['availability'],
        'supplier': doc.data()['supplier'],
        'color': doc.data()['color'],
        'image': doc.data()['image'],
      };

      clothesList.add(clothesUrl);
    });

    return clothesList;
  }

  static Future<String> deleteClothes(String model) async {
    try {
      await _db.collection('Clothes').doc(model).delete();
      return 'Se ha Borrado correctamente';
    } catch (e) {
      return 'Error: No se pudo registrar correctamente';
    }
  }
}
