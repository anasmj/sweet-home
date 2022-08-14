// import 'package:intl/intl.dart';

//*TAKES DATETIME OBJECT AND RETURN IN EXPECTED FORMAT
class CustomFormatter {
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

  String monthYear(DateTime date) => "${months[date.month - 1]} "
      "'${date.year.toString().substring(2, 4)}"; //Oct '22

  String previousMonthYear() => "${months[DateTime.now().month - 2]} "
      "'${DateTime.now().year.toString().substring(2, 4)}"; //Oct '22
  String currentMonthYear() => "${months[DateTime.now().month - 1]} "
      "'${DateTime.now().year.toString().substring(2, 4)}"; //Oct '22

  //for understanding purpose
  // String formattedDateTime() {
  //   return "${now.day} ${months[now.month - 1]} ${now.year} ${now.hour}:${now.minute}:${now.second}";
  // }

  // String currentDateAndMonth() => "${now.day} ${months[now.month - 1]}"; //2 Aug

  // String monthAndDate() => DateFormat('MMMd').format(DateTime.now()); // Aug 2;

  // String monthAndYear() =>
  //     "${months[now.month - 1]}, " "${now.year}"; //Aug, 2022

  // String previousMonthAndYear() =>
  //     "${months[now.month - 2]}, " "${now.year}"; //Aug, 2022

  // String year() =>
  //     DateFormat('y').format(DateTime.now()).substring(0, 2); //2022;

  // String weekDay() =>
  //     DateFormat('EEEE').format(DateTime.now()).substring(0, 3); // Tue

  // String monthYear(DateTime dateTime) =>
  //     DateFormat('yMMMM').format(dateTime).toString().substring(0, 3);
}
