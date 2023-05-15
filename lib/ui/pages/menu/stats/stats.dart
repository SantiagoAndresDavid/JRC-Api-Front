import 'package:flutter/material.dart';
import 'package:jrc_front/ui/widgets/barGraph.dart';

class Stats extends StatefulWidget {
  const Stats({super.key});

  @override
  State<Stats> createState() => _StatsState();
}

class _StatsState extends State<Stats> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Text(
          'Estadisticas del inventario',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(1000, 198, 169, 95),
          ),
        ),
        //BarGraph(),
      ],
    );
  }
}
