//TAKES STRING AND RETURNS VALIDATIONS
class Validator {
  static String? checkRenterName(String? value) {
    // needs to pass into validator
    if (value!.isEmpty) return 'গ্রাহকের নাম দেয়া হয়নি';

    return null; // null -> no problem
  }

  static String? checkPhoneNumber(String? value) {
    // needs to pass into validator
    if (value!.isEmpty) return 'ফোন নম্বর দেয়া হয়নি';
    if (value.length != 11) return 'ফোন নম্বরটি সঠিক নয়';

    return null; // null -> no problem
  }
}
