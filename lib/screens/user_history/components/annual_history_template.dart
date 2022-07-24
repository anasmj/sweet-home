import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart';
import '../../../models/month_details.dart';

Widget getAnnualRecordCard(
    {required List<MonthDetails> listOfMonthDetails, required int yearNo}) {
  List<Series<MonthDetails, String>> historyDataSeries = [
    Series(
        data: listOfMonthDetails,
        id: 'Annual History',
        domainFn: (MonthDetails history, _) => history.monthNmae,
        measureFn: (MonthDetails history, _) => history.paidAt,
        labelAccessorFn: (MonthDetails history, _) => history.paidAt.toString())
  ];

  return Card(
    child: Column(
      children: [
        SizedBox(
          height: 230,
          child: BarChart(
            historyDataSeries,
            animationDuration: const Duration(seconds: 1),
            animate: true,
            barRendererDecorator: BarLabelDecorator<String>(
                // insideLabelStyleSpec:  TextStyleSpec(fontSize: 12,color: Color.fromARGB(255, 126, 53, 53)),
                // outsideLabelStyleSpec: const TextStyleSpec(fontSize: 12),
                ),
            //domainAxis: const OrdinalAxisSpec(),
          ),
        ),
        Text(yearNo.toString()),
      ],
    ),
  );
}
