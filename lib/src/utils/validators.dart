
class Validator {
  static final phoneExp = RegExp(
      r'^\s*(?:\+?(\d{1,3}))?[-. (]*(\d{3})[-. )]*(\d{3})[-. ]*(\d{4})(?: *x(\d+))?\s*$');

  static String? password(String? s) {
    if (s!.isEmpty) return 'please choose a password';
    if (s.length < 6) return 'Must be at least 6 characters';
    return null;
  }

  static String? checkEmpty(String? s) {
    if (s!.isEmpty) return 'please choose a password';
    return null;
  }

  static String? phone(String? value) {
    if (phoneExp.hasMatch(value!)) return null;
    // if (value!.length > 9) return null;
    if (value.isEmpty) return 'Please provide that we can connect';
    return '';
  }
}
