import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:jrc_front/domain/clothes.dart';
import 'package:firebase_storage/firebase_storage.dart' as fs;
import 'package:path/path.dart' as path;

class ClothesRequest {
  static final fs.FirebaseStorage storage = fs.FirebaseStorage.instance;
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  static UploadTask? uploadTask;

  static Future<String> saveClothes(Clothes clothes) async {
    try {
      var url = await uploadFile(clothes.image);

      var clothesUrl = {
        'id': clothes.id,
        'model': clothes.model,
        'size': clothes.size,
        'availability': clothes.availability,
        'supplier': clothes.supplier,
        'color': clothes.color,
        'image': url.toString(),
      };

      await _db.collection('Clothes').doc(clothes.id).set(clothesUrl);

      return 'Se ha Registrado Correctamente';
    } catch (e) {
      return 'Error: No se pudo registrar correctamente';
    }
  }

  static Future<String> uploadFile(File? selectedImage) async {
    if (selectedImage == null) {
      throw Exception('No se ha seleccionado ninguna imagen.');
    }

    String fileName = path.basename(selectedImage.path);
    final storagePath = 'Image/$fileName';
    try {
      final storage = FirebaseStorage.instance;
      final ref = storage.ref().child(storagePath);
      final uploadTask = ref.putFile(selectedImage);
      final snapshot = await uploadTask.whenComplete(() {});
      final urlDownload = await snapshot.ref.getDownloadURL();
      print('Link de descarga: $urlDownload');
      return urlDownload;
    } catch (error) {
      if (error is FirebaseException) {
        print('Error al subir la imagen: ${error.message}');
      } else {
        print('Error al subir la imagen: $error');
      }
      throw error; // Re-throw the error to handle it appropriately
    }
  }

  static Future<List<dynamic>> getAllClothes() async {
    List<dynamic> clothesList = [];

    var response = await _db.collection("Clothes").get();
    response.docs.forEach((doc) {
      var clothesUrl = {
        'id': doc.data()['id'],
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

  static Future<String> deleteClothes(String id) async {
    try {
      await _db.collection('Clothes').doc(id).delete();
      return 'Se ha Borrado correctamente';
    } catch (e) {
      return 'Error: No se pudo registrar correctamente';
    }
  }

  static Future<String> updateClothes(Clothes clothes) async {
    try {
      var url = await uploadFile(clothes.image);

      var clothesUrl = {
        'id': clothes.id,
        'model': clothes.model,
        'size': clothes.size,
        'availability': clothes.availability,
        'supplier': clothes.supplier,
        'color': clothes.color,
        'image': url.toString(),
      };
      await _db.collection('Clothes').doc(clothes.id).update(clothesUrl);
      return 'Se ha Actualizado Correctamente';
    } catch (e) {
      return 'Error: No se pudo Actualizar correctamente';
    }
  }
}
