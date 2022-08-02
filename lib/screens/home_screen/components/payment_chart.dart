import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

Map<String, double> pieData = {
  'Paid': 8,
  'Partially Paid': 1,
  'Not paid yet': 2,
};

List<Color> pieColorList = const [
  Color.fromARGB(255, 128, 238, 125),
  Color.fromARGB(255, 236, 222, 22),
  Color.fromARGB(255, 214, 59, 59),
];

class PaymentChart extends StatefulWidget {
  const PaymentChart({Key? key}) : super(key: key);

  @override
  State<PaymentChart> createState() => _PaymentChartState();
}

class _PaymentChartState extends State<PaymentChart> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return PieChart(
      animationDuration: const Duration(seconds: 3),
      dataMap: pieData,
      colorList: pieColorList,
      chartRadius: screenWidth / 2.3,
      centerText: 'Status',
      chartValuesOptions: const ChartValuesOptions(
        decimalPlaces: 0,
      ),
      legendOptions: const LegendOptions(
        legendPosition: LegendPosition.bottom,
        showLegendsInRow: true,
      ),
    );
  }
}
