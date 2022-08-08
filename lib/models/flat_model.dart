import 'package:rent_home/models/renter.dart';

import 'others_model.dart';

class Flat {
  String flatName;
  int rentAmount;
  double? gasBill, waterBill;
  double? electricityUnitPrice;
  List<OthersExpence>? othersExpences;
  Renter? renter;
  Flat({
    required this.flatName,
    this.rentAmount = 21500,
    this.gasBill = 600,
    this.waterBill = 800,
    this.electricityUnitPrice = 7.50,
    this.othersExpences,
    this.renter,
  });
}

List<Flat> flatList = [
  Flat(
    flatName: '1A',
    othersExpences: [
      OthersExpence(purpose: 'ময়লা', amount: 100),
      OthersExpence(purpose: 'সিঁড়ি', amount: 125)
    ],
  ),
  Flat(
    flatName: '1B',
    othersExpences: [
      OthersExpence(purpose: 'ময়লা', amount: 100),
      OthersExpence(purpose: 'সিঁড়ি', amount: 125)
    ],
  ),
  Flat(
    flatName: '2A',
    othersExpences: [
      OthersExpence(purpose: 'ময়লা', amount: 100),
      OthersExpence(purpose: 'সিঁড়ি', amount: 125)
    ],
  ),
  Flat(
    flatName: '2B',
    othersExpences: [
      OthersExpence(purpose: 'ময়লা', amount: 100),
      OthersExpence(purpose: 'সিঁড়ি', amount: 125)
    ],
  ),
  Flat(
    flatName: '3A',
    othersExpences: [
      OthersExpence(purpose: 'ময়লা', amount: 100),
      OthersExpence(purpose: 'সিঁড়ি', amount: 125)
    ],
  ),
  Flat(
    flatName: '3B',
    othersExpences: [
      OthersExpence(purpose: 'ময়লা', amount: 100),
      OthersExpence(purpose: 'সিঁড়ি', amount: 125)
    ],
  ),
  Flat(
    flatName: '4A',
    othersExpences: [
      OthersExpence(purpose: 'ময়লা', amount: 100),
      OthersExpence(purpose: 'সিঁড়ি', amount: 125)
    ],
  ),
  Flat(
    flatName: '4B',
    othersExpences: [
      OthersExpence(purpose: 'ময়লা', amount: 100),
      OthersExpence(purpose: 'সিঁড়ি', amount: 125)
    ],
  ),
  Flat(
    flatName: '5A',
    othersExpences: [
      OthersExpence(purpose: 'ময়লা', amount: 100),
      OthersExpence(purpose: 'সিঁড়ি', amount: 125)
    ],
  ),
  Flat(
    flatName: '5B',
    othersExpences: [
      OthersExpence(purpose: 'ময়লা', amount: 100),
      OthersExpence(purpose: 'সিঁড়ি', amount: 125)
    ],
  ),
];
