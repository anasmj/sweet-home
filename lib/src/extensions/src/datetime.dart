part of '../extensions.dart';

extension DateUtils on DateTime {
  static final monthsBn = [
    "জানু",
    "ফেব্রু",
    "মার্চ",
    "এপ্রিল",
    "মে",
    "জুন",
    "জুলাই",
    "আগস্ট",
    "সেপ্টেম্বর",
    "অক্টোবর",
    "নভেম্বর",
    "ডিসেম্বর"
  ];
  static dynamic toBn({
    dynamic value,
    bool includeSymbol = true,
  }) {
    dynamic res = NumberFormat.currency(
      locale: 'bn-IN',
      decimalDigits: 0,
      symbol: '',
    ).format(value);
    return includeSymbol ? '৳$res' : res;
  }

  //অক্টোবর '২২
  String get previousMonthYear => "${monthsBn[DateTime.now().month - 2]} "
      " '${toBn(value: int.parse(DateTime.now().year.toString().substring(2, 4)), includeSymbol: false)}";
  //১১ নভেম্বর '২২
  String formatted() =>
      '${toBn(value: day, includeSymbol: false)} ${monthsBn[month - 1]} \'${toBn(value: int.parse(year.toString().substring(2, 4)), includeSymbol: false)}'; //${DateFormat.jm().format(timeStamp)}';
  // String toformattedDate({
  //   required DateTime dateTime,
  // }) =>
  //     '${toBn(value: dateTime.day, includeSymbol: false)} ${monthsBn[dateTime.month - 1]}  \'${toBn(value: int.parse(dateTime.year.toString().substring(2, 4)), includeSymbol: false)}'; //${DateFormat.jm().format(timeStamp)}';
}
