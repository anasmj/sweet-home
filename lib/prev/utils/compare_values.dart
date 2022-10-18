class Utils {
  static String? compareValues(
      {required dynamic value,
      required dynamic compareWith,
      bool isRequired = true}) {
    value = value.toString();
    compareWith = compareWith.toString();
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
