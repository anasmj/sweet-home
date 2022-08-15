import 'package:flutter/cupertino.dart';

import '../models/flat_model.dart';
import '../models/month_details.dart';
import '../models/others_model.dart';
import '../models/renter.dart';
import '../models/transaction_model.dart';
import '../models/year.dart';

class HomeProvider extends ChangeNotifier {
  final String _homeName = '';
  final String _ownerName = '';
  final String _address = '';

  final int _homeRentAmount = 8500;
  // List<OthersExpence>? _otherExpenceList; //!this line gives error
  final double _homeGasBill = 600;

  final double _homeWaterBill = 0;
  final double _electricityUnitPrice = 7.50;

  // List<Flat>? _flats = flatList;

  String get homeName => _homeName;
  String get ownerName => ownerName;
  String get address => _address;

  List<Flat> get flats => flatList;
  double get electricityUnitPrice => _electricityUnitPrice;
  int get homeRentAmount => _homeRentAmount;
  List<OthersExpence>? get homeOtherExpences => otherExpenceList;
  double? get homeGasbill => _homeGasBill;
  double? get homewaterBill => _homeWaterBill;
}

//some demo list of other expences and flats
List<OthersExpence> otherExpenceList = [
  OthersExpence(purpose: 'ময়লা', amount: 100.00),
  OthersExpence(purpose: 'সিঁড়ি মোছা', amount: 125.00),
];

List<Flat> flatList = [
  Flat(
    flatRentAmount: 7500,
    flatName: '1A',
    renter: Renter(
      name: 'আশরাফুল আলম',
      entryDate: DateTime.parse("2022-04-19"),
      numOfPerson: 3,
      records: <Year>[
        Year(
          yearNo: 2022,

          ///living for three months
          months: <MonthDetails>[
            MonthDetails(
              monthNmae: 'Apr',
              readingOfElecctricMeter: 7458.00, //random electricity unit
              transactions: [
                Transaction(
                    timeStamp: DateTime.parse("2022-04-03 20:18:04Z"),
                    takenAmount: 8000.00,
                    transactionBy: 'আশরাফুল আলম',
                    isAdvance: true,
                    due: 0),
              ],
            ),
            MonthDetails(
              monthNmae: 'May',
              readingOfElecctricMeter: 7338.39, //first month usage is zero
              transactions: [
                Transaction(
                    timeStamp: DateTime.parse("2022-05-07 20:18:04Z"),
                    transactionBy: 'আশরাফুল আলম',
                    takenAmount: 8450.00,
                    due: -230),
              ],
            ),
            MonthDetails(
              monthNmae: 'Jun',
              readingOfElecctricMeter: 7450.00,
              transactions: [
                Transaction(
                    timeStamp: DateTime.parse("2022-06-06 20:18:04Z"),
                    transactionBy: 'আশরাফুল আলম',
                    takenAmount: 8760.00,
                    due: 12),
              ],
            ),
          ],
        ),
      ],
    ),
  ),

  //divided into two years
  Flat(
    flatName: '1B',
    renter: Renter(
      name: 'দিদার হোসাইন',
      entryDate: DateTime.parse("2022-10-04"),
      numOfPerson: 2,
      records: <Year>[
        Year(
          yearNo: 2022,

          ///living for six months
          months: <MonthDetails>[
            MonthDetails(
              monthNmae: 'Nov',
              readingOfElecctricMeter: 7458.00, //random electricity unit
              transactions: [
                Transaction(
                  timeStamp: DateTime.parse("2022-11-05"),
                  takenAmount: 16000.00,
                  isAdvance: true,
                ),
              ],
            ),
            MonthDetails(
              monthNmae: 'Dec',
              readingOfElecctricMeter: 7338.39,
              transactions: [
                Transaction(
                  timeStamp: DateTime.parse("2022-12-10"),
                  takenAmount: 8450.00,
                ),
              ],
            ),
          ],
        ),

        //2nd year
        Year(
          yearNo: 2023,
          months: <MonthDetails>[
            MonthDetails(
              monthNmae: 'Jan',
              readingOfElecctricMeter: 7450.00,
              transactions: [
                Transaction(
                  timeStamp: DateTime.parse("2022-10-04"),
                  takenAmount: 8760.00,
                ),
              ],
            ),
            MonthDetails(
              monthNmae: 'Feb',
              readingOfElecctricMeter: 7450.00,
              transactions: [
                Transaction(
                  timeStamp: DateTime.parse("2022-10-04"),
                  takenAmount: 8760.00,
                ),
              ],
            ),
            MonthDetails(
              monthNmae: 'Mar',
              readingOfElecctricMeter: 8450.00,
              transactions: [
                Transaction(
                  timeStamp: DateTime.parse("2022-10-04"),
                  takenAmount: 8760.00,
                ),
              ],
            ),
          ],
        ),

        //TODO: make sure
        //!if electric bill functions from december to january
      ],
    ),
  ),

  //living for two months
  Flat(
    flatName: '2A',
    renter: Renter(
      name: 'রিফাত হাওলাদার',
      entryDate: DateTime.parse("2022-08-04"),
      numOfPerson: 2,
      records: <Year>[
        Year(
          yearNo: 2022,
          months: <MonthDetails>[
            MonthDetails(
              monthNmae: 'Aug',
              readingOfElecctricMeter: 7458.00, //random electricity unit
              transactions: [
                Transaction(
                  timeStamp: DateTime.parse("2022-08-05"),
                  takenAmount: 16000.00,
                  isAdvance: true,
                ),
              ],
            ),
            MonthDetails(
              monthNmae: 'Sep',
              readingOfElecctricMeter: 7338.39,
              transactions: [
                Transaction(
                  timeStamp: DateTime.parse("2022-09-10"),
                  takenAmount: 8450.00,
                ),
              ],
            ),
            MonthDetails(
              monthNmae: 'Oct',
              readingOfElecctricMeter: 7450.00,
              transactions: [
                Transaction(
                  timeStamp: DateTime.parse("2022-10-02"),
                  takenAmount: 8760.00,
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ),
  Flat(
    flatName: '2B',
  ),
  Flat(
    flatName: '3A',
  ),
  Flat(
    flatName: '3B',
  ),
  Flat(
    flatName: '4A',
  ),
  Flat(
    flatName: '4B',
  ),
  Flat(
    flatName: '5A',
  ),
  Flat(
    flatName: '5B',
  ),
];
