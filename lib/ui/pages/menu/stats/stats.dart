import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../controllers/clothes/clothesController.dart';

class Stats extends StatefulWidget {
  final String? model;

  const Stats({Key? key, this.model}) : super(key: key);

  @override
  State<Stats> createState() => _StatsState();
}

class _StatsState extends State<Stats> {
  ClothesController controller = ClothesController();
  List<dynamic> list = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    try {
      setState(() {
        isLoading = true;
      });
      List<dynamic> clothes = await controller.GetAllClothes();
      setState(() {
        list = List.from(clothes); // Guardar los elementos en la lista
        isLoading = false;
      });
    } catch (error) {
      print('Error: $error');
      setState(() {
        isLoading = false;
      });
    }
  }

  List<dynamic> getSupplierData(List<dynamic> list) {
    Map<String, int> supplierData = {};

    for (var item in list) {
      String supplier = item['supplier'];
      if (supplierData.containsKey(supplier)) {
        supplierData[supplier] = supplierData[supplier]! + 1;
      } else {
        supplierData[supplier] = 1;
      }
    }

    List<dynamic> result = [];

    supplierData.forEach((supplier, count) {
      result.add({'supplier': supplier, 'total': count});
    });

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Estadisticas del inventario',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(1000, 198, 169, 95),
          ),
        ),
        if (isLoading)
          const CircularProgressIndicator(
              color: Color.fromARGB(1000, 198, 169, 95))
        else
          Column(
            children: [
              Container(
                height: 300,
                child: SfCartesianChart(
                  primaryXAxis: CategoryAxis(
                    title: AxisTitle(
                      text: 'Modelo',
                      textStyle: const TextStyle(
                        color: Color.fromARGB(1000, 198, 169, 95),
                      ),
                    ),
                  ),
                  primaryYAxis: NumericAxis(
                    title: AxisTitle(
                      text: 'Disponibilidad',
                      textStyle: const TextStyle(
                        color: Color.fromARGB(1000, 198, 169, 95),
                      ),
                    ),
                  ),
                  series: <ChartSeries>[
                    ColumnSeries<dynamic, String>(
                      dataSource: list,
                      yValueMapper: (dynamic data, _) {
                        // Validar y parsear el valor a num?
                        num? availability = num.tryParse(data['availability']);
                        return availability;
                      },
                      xValueMapper: (dynamic data, _) => data['model'],
                      color: const Color.fromARGB(1000, 198, 169, 95),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(16.0),
                    child: SfCircularChart(
                      series: <CircularSeries>[
                        PieSeries<dynamic, String>(
                          dataSource: getSupplierData(list),
                          xValueMapper: (dynamic data, _) => data['supplier'],
                          yValueMapper: (dynamic data, _) => data['total'],
                          dataLabelSettings: DataLabelSettings(isVisible: true),
                          enableTooltip: true,
                          pointColorMapper: (dynamic data, _) {
                            final mainColor =
                                Color.fromARGB(1000, 198, 169, 95);
                            final totalValues = getSupplierData(list)
                                .map((data) => data['total'])
                                .toList();
                            final minValue = totalValues.reduce(
                                (min, value) => value < min ? value : min);
                            final maxValue = totalValues.reduce(
                                (max, value) => value > max ? value : max);
                            final value = data['total'];
                            final luminosity = 1 -
                                ((value - minValue) / (maxValue - minValue));
                            final double luminosityDouble =
                                luminosity.toDouble();
                            final color = Color.lerp(
                                mainColor, Colors.white, luminosityDouble);
                            return color ?? mainColor;
                          },
                        ),
                      ],
                      legend: Legend(isVisible: true),
                    ),
                  ),
                ],
              ),
            ],
          ),
      ],
    );
  }
}
