import 'package:flutter/material.dart';

class ClothesListWidget extends StatefulWidget {
  final List<dynamic> clothesList;

  const ClothesListWidget({Key? key, required this.clothesList})
      : super(key: key);

  @override
  _ClothesListWidgetState createState() => _ClothesListWidgetState();
}

class _ClothesListWidgetState extends State<ClothesListWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 550,
      child: widget.clothesList.isEmpty
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
              itemCount: widget.clothesList.length,
              itemBuilder: (BuildContext context, int index) {
                final dynamic clothesItem = widget.clothesList[index];
                var itemName = clothesItem["model"];
                return Container(
                  height: 100,
                  color: Colors.white,
                  child: Center(child: Text(itemName)),
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
            ),
    );
  }
}
