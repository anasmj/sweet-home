import 'package:sweet_home/src/constants/constants.dart';

class Renter {
  String? renterName;
  String? id;
  String? phone;
  String? phone2;
  String? occupation;
  int? numOfPerson;
  DateTime? entryDate;
  String? previousAddress;
  String? permanentAddress;
  double renterDue;

  Renter({
    this.renterName,
    this.id,
    this.phone,
    this.phone2 = '',
    this.occupation = '',
    this.entryDate,
    this.numOfPerson,
    this.previousAddress,
    this.permanentAddress,
    this.renterDue = 0,
  });

  static Renter fromJson(Map<String, dynamic> json) {
    Renter renter = Renter(
      renterName: json[RenterField.name],
      id: json[RenterField.id],
      phone: json[RenterField.ph],
      phone2: json[RenterField.ph2] ?? '',
      occupation: json[RenterField.occupation_] ?? '',
      entryDate: DateTime.parse(json[RenterField.entryDate_]),
      numOfPerson: json[RenterField.numOfPerson_] ?? 1,
      previousAddress: json[RenterField.previousAddress] ?? '',
      permanentAddress: json[RenterField.permanentAddress] ?? '',
    );
    return renter;
  }

  Map<String, dynamic> toJson() {
    return {
      RenterField.name: renterName,
      RenterField.id: id,
      RenterField.ph: phone,
      RenterField.ph2: phone2 ?? '',
      RenterField.occupation_: occupation ?? '',
      RenterField.numOfPerson_: numOfPerson ?? 1,
      RenterField.entryDate_: entryDate.toString(),
      RenterField.previousAddress: previousAddress ?? '',
      RenterField.permanentAddress: permanentAddress ?? '',
    };
  }

  Renter copyWith({
    String? renterName,
    String? id,
    String? phone,
    String? phone2,
    String? occupation,
    int? numOfPerson,
    DateTime? entryDate,
    int? nIdNumber,
    String? previousAddress,
    String? permanentAddress,
    String? village,
    String? policeStation,
    String? union,
    String? subDistrict,
    String? district,
    String? advance,
  }) {
    return Renter(
      renterName: renterName ?? this.renterName,
      id: id ?? this.id,
      phone: phone ?? this.phone,
      phone2: phone2 ?? this.phone2,
      occupation: occupation ?? this.occupation,
      numOfPerson: numOfPerson ?? this.numOfPerson,
      entryDate: entryDate ?? this.entryDate,
      previousAddress: previousAddress ?? this.previousAddress,
      permanentAddress: permanentAddress ?? this.permanentAddress,
    );
  }

  @override
  String toString() {
    return 'Renter(renterName: $renterName, id: $id, phone: $phone, alternatePhoneNo: $phone2, occupation: $occupation, numOfPerson: $numOfPerson, entryDate: $entryDate, prevAddress: $previousAddress, permanentAddress: $permanentAddress';
  }

  @override
  bool operator ==(covariant Renter other) {
    if (identical(this, other)) return true;

    return other.renterName == renterName && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
