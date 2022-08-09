// import 'package:flutter/material.dart';
// // import 'package:charts_flutter/flutter.dart';
// import 'package:charts_flutter/flutter.dart' as charts;
// import '../../../models/month_details.dart';

// Widget getAnnualRecordCard(
//     {required List<MonthDetails> listOfMonthDetails, required int yearNo}) {
//   List<charts.Series<MonthDetails, String>> historyDataSeries = [
//     charts.Series(
//         data: listOfMonthDetails,
//         id: 'Annual History',
//         domainFn: (MonthDetails history, _) => history.monthNmae,
//         measureFn: (MonthDetails history, _) => history.paidAt,
//         labelAccessorFn: (MonthDetails history, _) => history.paidAt.toString())
//   ];

//   return Card(
//     elevation: 8.0,
//     child: Column(
//       children: [
//         Stack(
//           alignment: Alignment.topCenter,
//           children: [
//             SizedBox(
//               height: 230,
//               child: charts.BarChart(
//                 historyDataSeries,
//                 animationDuration: const Duration(seconds: 1),
//                 animate: true,
//                 barRendererDecorator: charts.BarLabelDecorator<String>(
//                     // insideLabelStyleSpec:  TextStyleSpec(fontSize: 12,color: Color.fromARGB(255, 126, 53, 53)),
//                     // outsideLabelStyleSpec: const TextStyleSpec(fontSize: 12),
//                     ),
//                 //domainAxis: const OrdinalAxisSpec(),
//               ),
//             ),
//             const Text(
//               //yearNo.toString(),
//               'চলতি বছরের রেকর্ড',
//               style: TextStyle(fontSize: 18),
//             ),
//           ],
//         ),
//       ],
//     ),
//   );
// }
