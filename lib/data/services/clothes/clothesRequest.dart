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

  static Future<String> uploadFile(File? selectedImage) async {
    String fileName = path.basename(selectedImage!.path);
    final storagePath = 'Image/$fileName';

    try {
      final storage = FirebaseStorage.instance;
      final ref = storage.ref().child(storagePath);
      final uploadTask = ref.putFile(selectedImage);

      // Check if the image already exists
      final existingSnapshot = await ref.getDownloadURL();
      if (existingSnapshot != null) {
        // Image already exists, return the existing download URL
        return existingSnapshot;
      }

      final snapshot = await uploadTask.whenComplete(() {});
      final urlDownload = await snapshot.ref.getDownloadURL();
      log('Link de descarga: $urlDownload');
      return urlDownload;
    } catch (error) {
      if (error is FirebaseException) {
        log('Error al subir la imagen: ${error.message}');
      } else {
        log('Error al subir la imagen: $error');
      }
      throw error; // Re-throw the error to handle it appropriately
    }
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

  /*Future<void> updateClothe(Clothes clothes) async {
    await _db.collection('estados').doc(id).update(cliente).catchError((e) {
      print(e);
    });
    //return true;
  }*/
}
