// import 'package:intl/intl.dart';

//*TAKES DATETIME OBJECT AND RETURN IN EXPECTED FORMAT
import 'package:intl/intl.dart';

class Formatter {
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
  //convert to bengali number
  static DateTime get previousDate => DateTime(
      DateTime.now().year, DateTime.now().month - 1, DateTime.now().day);

  static dynamic toBn({dynamic value, bool includeSymbol = true}) {
    dynamic res = NumberFormat.currency(
      locale: 'bn-IN',
      decimalDigits: 0,
      symbol: '',
    ).format(value);
    return includeSymbol ? '৳$res' : res;
  }

  //23 Jan '22
  String buttonFormat(DateTime timeStamp) =>
      '${timeStamp.day} ${months[timeStamp.month - 1]} ${timeStamp.year.toString().substring(2, 4)}';

  //Oct '22
  String monthYear(DateTime date) => "${months[date.month - 1]} "
      "'${date.year.toString().substring(2, 4)}";

  //convert date in 2022-09-20 format
  static String makeId(DateTime date) => DateFormat('yyyy-MM').format(date);

  //2022-09-20 currentDate
  String yearMonthDate() => DateFormat('yyyy-MM-dd').format(DateTime.now());

  //Oct '22
  String previousMonthYear() => "${months[DateTime.now().month - 2]} "
      "'${DateTime.now().year.toString().substring(2, 4)}";

  //Oct '22
  String currentMonthYear() => "${months[DateTime.now().month - 1]} "
      "'${DateTime.now().year.toString().substring(2, 4)}";

  //23 Jan '22 03:20pm
  String transactionTime(DateTime timeStamp) =>
      '${timeStamp.day} ${months[timeStamp.month - 1]} \'${DateTime.now().year.toString().substring(2, 4)} ${DateFormat.jm().format(timeStamp)}';
  String appDateTime(DateTime timeStamp) =>
      '${timeStamp.day} ${months[timeStamp.month - 1]} ${DateFormat.jm().format(timeStamp)}';

  // String transactionTime(DateTime timeStamp) =>
  //     "${timeStamp.day} ${months[timeStamp.month - 1]}";

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

  // String year() => DateFormat('y').format(DateTime.now()); //2022;

  // String weekDay() =>
  //     DateFormat('EEEE').format(DateTime.now()).substring(0, 3); // Tue

  // String monthYear(DateTime dateTime) =>
  //     DateFormat('yMMMM').format(dateTime).toString().substring(0, 3);
}
