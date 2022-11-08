dynamic castToDbFieldValue(
    {required String value, bool isDouble = false, bool isInt = false}) {
  if (value.isEmpty) return;
  if (isDouble) return double.parse(value);
  if (isInt) return int.parse(value);
  return value;
}

String getFirebaseFieldName({required String title}) {
  final displayFieldToDbField = {
    //app field | DB fields
    'বাড়ীর নাম': 'homeName',
    'ভাড়া': 'rentAmount',
    'ঠিকানা': 'location',
    'তলা': 'floor',
    'ফ্লোরে ফ্ল্যাট সংখ্যা': 'flatPerFloor',
    'গ্যাস': 'gasBill',
    'পানি': 'waterBill',
    'বর্তমান রিডিং': 'presentMeterReading',
    'পূর্বের রিডিং': 'previousMeterReading',
    // 'অন্যান্য' : 'Others'
  };

  String selectedFirebaseField = displayFieldToDbField[title] ?? 'Not found';

  return selectedFirebaseField;
}
