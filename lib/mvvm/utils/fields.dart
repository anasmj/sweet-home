//!CAUTION: COPY DB FIELDS ONLY
class FlatField {
  static String get name => 'flatName';
  static String get rent => 'rentAmount';
  static String get gas => 'gasBill';
  static String get water => 'waterBill';
  static String get presentReading => 'presentMeterReading';
  static String get previousReading => 'previousMeterReading';
  static String get previousTime => 'previousMeterReadingUpdateTime';
  static String get presentTime => 'presentMeterReadingUpdateTime';
  static String get due => 'monthlyDue';
  static String get confirmDate => 'confirmDate';
  static String get renter => 'renter';
}

class RenterField {
  static String get name => 'renterName';
  static String get id => 'id';
  static String get ph => 'phoneNo';
  static String get ph2 => 'alternatePhoneNo';
  static String get occupation_ => 'occupation';
  static String get entryDate_ => 'entryDate';
  static String get numOfPerson_ => 'numOfPerson';
  static String get previousLocation_ => 'previousLocation';
  static String get vill => 'village';
  static String get policeSt => 'policeStation';
  static String get union_ => 'union';
  static String get subDistrict_ => 'subDistrict';
  static String get dist_ => 'district';
  static String get nId => 'nIdNumber';
  static String get transactions_ => 'transactions';
  static String get due_ => 'renterDue';
}
