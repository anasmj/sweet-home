class Utils {
  static String? compareValues(
      {required String value,
      required String compareWith,
      bool isRequired = true}) {
    if (isRequired) {
      if (value.isEmpty) {
        return 'কোনও তথ্য দেয়া হয়নি';
      }
      if (value.trim() == compareWith.trim()) {
        return 'কোনও তথ্য পরিবর্তন হয়নি';
      } else {
        return null;
      }
    } else {
      if (value.trim() == compareWith.trim()) {
        return 'কোনও তথ্য পরিবর্তন হয়নি';
      } else {
        return null;
      }
    }
  }
}
