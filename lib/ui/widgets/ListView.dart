import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/clothes/clothesController.dart';

class ClothesListWidget extends StatefulWidget {
  final String? model;

  const ClothesListWidget({Key? key, this.model}) : super(key: key);

  @override
  _ClothesListWidgetState createState() => _ClothesListWidgetState();
}

class _ClothesListWidgetState extends State<ClothesListWidget> {
  ClothesController controller = ClothesController();
  List<dynamic> list = []; // Lista local
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    try {
      List<dynamic> clothes = await controller.GetAllClothes();

      if (widget.model != null && widget.model!.isNotEmpty) {
        clothes = clothes
            .where((item) => item['model'].contains(widget.model!))
            .toList();
      }
      setState(() {
        list = clothes;
      });
    } catch (error) {
      print('Error: $error');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 550,
      child: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Color.fromARGB(1000, 198, 169, 95),
              ),
            )
          : list.isEmpty
              ? const Center(
                  child: Text(
                    'No se encontraron resultados',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(1000, 198, 169, 95),
                    ),
                  ),
                )
              : ListView.separated(
                  padding: const EdgeInsets.all(8),
                  itemCount: list.length,
                  itemBuilder: (BuildContext context, int index) {
                    final dynamic clothesItem = list[index];
                    var itemName = clothesItem["model"];

                    return Dismissible(
                      key: Key(clothesItem["model"]),
                      onDismissed: (direction) {
                        setState(() {
                          list.removeAt(index); // Remove the item from the list
                          controller.DeleteClothes(itemName);
                        });
                        Get.snackbar(
                          'Validacion de datos',
                          'Se ha borrando con exito',
                          snackPosition: SnackPosition.TOP,
                          backgroundColor: Colors.green,
                          colorText: Colors.white,
                          duration: const Duration(seconds: 3),
                        );
                      },
                      // Muestra un background rojo a medida que el elemento se elimina
                      background: Container(color: Colors.red),
                      child: Container(
                        height: 100,
                        color: Colors.white,
                        child: Center(child: Text(itemName)),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(),
                ),
    );
  }
}
