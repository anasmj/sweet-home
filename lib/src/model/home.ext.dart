part of 'home.dart';

extension HomeExtension on Home {
  Home copyWith({
    String? homeId,
    homeName,
    location,
    int? floor,
    flatPerFloor,
    rentAmount,
    gasBill,
    waterBill,
    List<Utility>? utilities,
  }) =>
      Home(
        homeId: homeId ?? this.homeId,
        homeName: homeName ?? this.homeName,
        location: location ?? this.location,
        floor: floor ?? this.floor,
        flatPerFloor: flatPerFloor ?? this.flatPerFloor,
        rentAmount: rentAmount ?? this.rentAmount,
        gasBill: gasBill ?? this.gasBill,
        waterBill: waterBill ?? this.waterBill,
      );
  Map<String, dynamic> toJson() => {
        'homeId': homeId,
        'homeName': homeName,
        'location': location,
        'floor': floor,
        'flatPerFloor': flatPerFloor,
        'rentAmount': rentAmount,
        'gasBill': gasBill ?? 0.00,
        'waterBill': waterBill ?? 0.00,
        'utilities': utilities,
      };
  static Home fromJson(Map<String, dynamic> data) => Home(
        homeName: data['homeName'] ?? '',
        homeId: data['homeId'] ?? '',
        rentAmount: data['rentAmount'] ?? 0.00,
        location: data['location'] ?? '',
        flatPerFloor: data['flatPerFloor'] ?? 0,
        floor: data['floor'] ?? 0,
        gasBill: data['gasBill'] ?? 0.00,
        waterBill: data['waterBill'] ?? 0.00,
        // serviceCharges:
      );

  List<String> getFlatsAsList({
    required int floorRange,
    required int flatRange,
  }) {
    List<String> finalFlatList = [];
    if ((floorRange > 0 && floorRange < 9) &&
        (flatRange > 0 && flatRange < 10)) {
      //convert user choice to usable 1D list
      for (int floorNo = 0; floorNo < floorRange; floorNo++) {
        for (int flatIndex = 0; flatIndex < flatRange; flatIndex++) {
          finalFlatList.add(_userFlatOptions[floorNo][flatIndex]);
        }
      }
      return finalFlatList;
    }
    return [];
  }

  static final List<List<String>> _userFlatOptions = [
    ['1A', '1B', '1C', '1D', '1E', '1F', '1G', '1H', '1I', '1J'],
    ['2A', '2B', '2C', '2D', '2E', '2F', '2G', '2H', '2I', '2J'],
    ['3A', '3B', '3C', '3D', '3E', '3F', '3G', '3H', '3I', '3J'],
    ['4A', '4B', '4C', '4D', '4E', '4F', '4G', '4H', '4I', '4J'],
    ['5A', '5B', '5C', '5D', '5E', '5F', '5G', '5H', '5I', '5J'],
    ['6A', '6B', '6C', '6D', '6E', '6F', '6G', '6H', '6I', '6J'],
    ['7A', '7B', '7C', '7D', '7E', '7F', '7G', '7H', '7I', '7J'],
    ['8A', '8B', '8C', '8D', '8E', '8F', '8G', '8H', '8I', '8J'],
    ['9A', '9B', '9C', '9D', '9E', '9F', '9G', '9H', '9I', '9J'],
  ];
}
