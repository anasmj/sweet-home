import 'package:intl/intl.dart';

class DateAndTime {
  var months = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];

  DateTime now = DateTime.now();

  String formattedDateTime() {
    return "${now.day} ${months[now.month - 1]} ${now.year} ${now.hour}:${now.minute}:${now.second}";
  }

  String currentDateAndMonth() => "${now.day} ${months[now.month - 1]}"; //2 Aug

  String monthAndDate() => DateFormat('MMMd').format(DateTime.now()); // Aug 2;

  String monthAndYear() =>
      "${months[now.month - 1]}, " "${now.year}"; //Aug, 2022
  String previousMonthAndYear() =>
      "${months[now.month - 2]}, " "${now.year}"; //Aug, 2022

  String year() => DateFormat('y').format(DateTime.now()); //2022;

  String weekDay() =>
      DateFormat('EEEE').format(DateTime.now()).substring(0, 3); // Tue
}
