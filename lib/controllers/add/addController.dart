import 'dart:io';


import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:jrc_front/data/services/add/addRequest.dart';
import 'package:jrc_front/domain/clothes.dart';

class AddController extends GetxController {
  
    Future<String> SaveClothes(Clothes clothes) async {
    try {
      String response = await AddRequest.saveClothes(clothes);
      return response;
    } on FirebaseException catch (e) {
      return e.toString();
    }
  }
}
