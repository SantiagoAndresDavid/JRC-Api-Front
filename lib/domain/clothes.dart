import 'dart:io';

class Clothes {
  // ignore: prefer_typing_uninitialized_variables
  var id;
  var model;
  var size;
  var availability;
  var supplier;
  var color;
  File? image;

  Clothes({
    required this.id,
    required this.model,
    required this.size,
    required this.availability,
    required this.supplier,
    required this.color,
    required this.image,
  });
}
