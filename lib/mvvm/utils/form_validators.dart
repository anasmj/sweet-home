//TAKES STRING AND RETURNS VALIDATIONS
class FormValidators {
  static String? checkEmpty(String? value) {
    if (value!.isEmpty) return 'তথ্যটি দেয়া হয়নি';

    return null; // null -> no problem
  }

  static String? checkNonZero(String? value) {
    if (value!.isEmpty) return 'তথ্যটি দেয়া হয়নি';
    if (value == '.') return 'তথ্যটি সঠিক নয়';
    if (double.parse(value) <= 0) return 'তথ্যটি সঠিক নয়';
    return null; // null -> no problem
  }

  static String? checkHomeName(String? value) {
    if (value!.isEmpty) return 'গ্রাহকের নাম দেয়া হয়নি';

    return null; // null -> no problem
  }

  static String? checkLocation(String? value) {
    if (value!.isEmpty) return 'ঠিকানা উল্লেখ করা হয়নি';

    return null;
  }

  static String? checkRentAmount(String? value) {
    if (value!.isEmpty) return 'বাড়ী ভাড়া উল্লেখ করা হয়নি';
    return null;
  }

  static String? checkGasBill(String? value) {
    return null;
  }

  static String? checWaterBill(String? value) {
    return null;
  }

  //RENTER STEPPER CONTROLLERS

  static String? checkRenterName(String? value) {
    if (value!.isEmpty) return 'গ্রাহকের নাম দেয়া হয়নি';

    return null;
  }

  static String? checkPhoneNumber(
    String? value,
  ) {
    if (value!.isEmpty) return 'ফোন নম্বর দেয়া হয়নি';
    if (value.length != 11) return 'ফোন নম্বরটি সঠিক নয়';

    return null;
  }
}
