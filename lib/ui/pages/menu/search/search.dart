import 'package:flutter/material.dart';
import 'package:jrc_front/ui/utils/dimensions.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Text(
          'Busqueda de inventario',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(1000, 198, 169, 95),
          ),
        ),
        SizedBox(
          width: 500,
        )
      ],
    );
  }
}
