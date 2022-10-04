import 'package:sweet_home/prev/models/month_details.dart';

class Year {
  int yearNo;
  List<MonthDetails> months; //there can be 12 month detail in a year
  Year({required this.yearNo, required this.months});
}
