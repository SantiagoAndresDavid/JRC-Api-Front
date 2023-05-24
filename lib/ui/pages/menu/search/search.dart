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
  TextEditingController modelController = TextEditingController();
  ClothesController controller = ClothesController();
  bool _showClothesList = false;
  Key _clothesListKey = UniqueKey();

  @override
  void initState() {
    super.initState();
  }

  void _searchClothes() {
    setState(() {
      _showClothesList = true;
      _clothesListKey =
          UniqueKey(); // Genera una nueva clave única para recargar el widget
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
                modelController,
                "search",
                const EdgeInsets.all(0),
                const EdgeInsets.only(bottom: 8),
                const Color.fromARGB(255, 197, 197, 197),
                Colors.grey.shade700,
              ),
            ),
            IconButton(
              onPressed: _searchClothes,
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
        if (_showClothesList || modelController.text.isEmpty)
          ClothesListWidget(
            key: _clothesListKey, // Asigna la clave única al widget
            model: modelController.text,
          ),
      ],
    );
  }
}
