import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jrc_front/ui/widgets/ClothesDetailsDialog.dart';
import 'package:jrc_front/ui/widgets/EditItemDialog.dart';

import '../../controllers/clothes/clothesController.dart';

class ClothesListWidget extends StatefulWidget {
  final String? model;

  const ClothesListWidget({Key? key, this.model}) : super(key: key);

  @override
  _ClothesListWidgetState createState() => _ClothesListWidgetState();
}

class _ClothesListWidgetState extends State<ClothesListWidget> {
  ClothesController controller = ClothesController();
  List<dynamic> list = [];
  bool isLoading = true;
  int selectedIndex = -1;

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

  void showDetailsDialog(dynamic clothesItem) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ClothesDetailsDialog(clothesItem: clothesItem);
      },
    );
  }

  Future<void> deleteItem(dynamic clothesItem, int index) async {
    setState(() {
      list.removeAt(index);
      isLoading = true;
    });

    await controller.DeleteClothes(clothesItem["id"]);

    await loadData();

    Get.snackbar(
      'Validacion de datos',
      'Se ha borrado con éxito',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
    );
  }

  Future<bool> showDeleteConfirmation() async {
    return await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Confirmar eliminación'),
              content:
                  Text('¿Estás seguro de que deseas eliminar este elemento?'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: const Text(
                    'Cancelar',
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: const Text(
                    'Aceptar',
                    style: TextStyle(
                      color: Color.fromARGB(1000, 198, 169, 95),
                    ),
                  ),
                ),
              ],
            );
          },
        ) ??
        false;
  }

  Future<void> editItem(dynamic clothesItem) async {
    bool? result = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return EditItemDialog(
          clothesItem: clothesItem,
          onConfirm: (bool value) async {
            if (value) {
              Get.snackbar(
                'Validacion de datos',
                'Se ha actualizado con éxito',
                snackPosition: SnackPosition.TOP,
                backgroundColor: Colors.green,
                colorText: Colors.white,
                duration: const Duration(seconds: 3),
              );
              await loadData(); // Update the list after confirming the edit
            }
          },
        );
      },
    );
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
                    var itemName = clothesItem["id"];
                    return Dismissible(
                      key: Key(clothesItem["id"]),
                      direction: DismissDirection.horizontal,
                      confirmDismiss: (direction) async {
                        if (direction == DismissDirection.startToEnd) {
                          final confirm = await showDeleteConfirmation();
                          if (confirm) {
                            deleteItem(clothesItem, index);
                          }
                          return confirm;
                        } else if (direction == DismissDirection.endToStart) {
                          editItem(clothesItem);
                        }
                        return false;
                      },
                      background: Container(
                        color: Colors.red,
                        child: const Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      secondaryBackground: Container(
                        color: Colors.blue,
                        child: const Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                          });
                          showDetailsDialog(clothesItem);
                        },
                        child: Container(
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: selectedIndex == index
                                ? Colors.grey.withOpacity(0.5)
                                : Colors.white,
                          ),
                          child: Center(child: Text(itemName)),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(),
                ),
    );
  }
}
