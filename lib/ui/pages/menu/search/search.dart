import 'package:flutter/material.dart';
import 'package:jrc_front/ui/utils/dimensions.dart';

import '../../../widgets/Input.dart';
import '../../../widgets/searchInput.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    String _searchQuery = '';
    TextEditingController searchController = TextEditingController();
    final List<String> entries = <String>[
      'A',
      'B',
      'C',
      'D',
      'E',
      'F',
      'G',
      'H',
      'I',
      'J',
      'K',
      'L',
      'M'
    ];
    final List<int> colorCodes = <int>[
      600,
      500,
      100,
      200,
      300,
      400,
      500,
      600,
      700,
      800,
      900,
      1000,
      1100
    ];

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
        SizedBox(height: 70, child: SearchScreen()),
        const SizedBox(height: 15),
        SizedBox(
            height: 550,
            child: ListView.separated(
              padding: const EdgeInsets.all(8),
              itemCount: entries.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: 100,
                  color: Colors.amber[colorCodes[index]],
                  child: Center(child: Text('Entry ${entries[index]}')),
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
            ))
      ],
    );
  }
}
