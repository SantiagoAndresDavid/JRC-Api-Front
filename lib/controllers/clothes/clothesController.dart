import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:jrc_front/data/services/clothes/clothesRequest.dart';
import 'package:jrc_front/domain/clothes.dart';

class ClothesController extends GetxController {
  Future<String> SaveClothes(Clothes clothes) async {
    try {
      String response = await ClothesRequest.saveClothes(clothes);
      return response;
    } on FirebaseException catch (e) {
      return e.toString();
    }
  }

  Future<List> GetAllClothes() async {
    return await ClothesRequest.getAllClothes();
  }

  Future<String> DeleteClothes(String model) async {
    return await ClothesRequest.deleteClothes(model);
    

  }
}
