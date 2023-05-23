import 'package:flutter/material.dart';
import 'package:jrc_front/controllers/clothes/clothesController.dart';
import 'package:jrc_front/domain/clothes.dart';
import 'package:jrc_front/ui/utils/dimensions.dart';

import '../../../widgets/Input.dart';
import '../../../widgets/ListView.dart';

class Search extends StatefulWidget {
  const Search({Key? key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController providerController = TextEditingController();
  ClothesController controller = ClothesController();

  List<dynamic> listClothes = [];
  List<dynamic> filteredClothes = []; // Nueva lista filtrada

  @override
  void initState() {
    super.initState();
    fetchClothes();
  }

  Future<void> fetchClothes() async {
    List<dynamic> clothes = await controller.GetAllClothes();
    setState(() {
      listClothes = clothes;
      filteredClothes = clothes; // Inicialmente, ambas listas son iguales
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Busqueda de inventario',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(1000, 198, 169, 95),
          ),
        ),
        const SizedBox(height: 30),
        Row(
          children: [
            const SizedBox(width: 15),
            SizedBox(
              width: 300,
              child: Input(
                false,
                providerController,
                "search",
                const EdgeInsets.all(0),
                const EdgeInsets.only(bottom: 8),
                const Color.fromARGB(255, 197, 197, 197),
                Colors.grey.shade700,
              ),
            ),
            IconButton(
              onPressed: () {
                searchClothes(providerController.text);
              },
              icon: const Icon(
                Icons.search,
                color: Color.fromARGB(1000, 198, 169, 95),
                size: 30,
              ),
              color: Colors.black,
              splashRadius: 20,
            ),
          ],
        ),
        const SizedBox(height: 15),
        ClothesListWidget(
            clothesList:
                filteredClothes), // Usar la lista filtrada en lugar de la lista original
      ],
    );
  }

  void searchClothes(String query) {
    setState(() {
      filteredClothes = listClothes
          .where((clothes) => clothes['model']
              .toString()
              .toLowerCase()
              .contains(query.toLowerCase()))
          .toList();
    });
  }
}
