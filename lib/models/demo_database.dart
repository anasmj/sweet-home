import 'package:flutter/cupertino.dart';
import 'package:rent_home/models/renter.dart';
import 'package:rent_home/models/transaction_model.dart';
import 'package:rent_home/models/year.dart';
import 'flat_model.dart';
import 'month_details.dart';
import 'others_model.dart';
import 'home_model.dart';

//*THIS WILL WORK AS DATABASE WHILE BUILDING THE APP

class Database extends ChangeNotifier {
  List<Home> homes = [
    Home(
      homeName: 'হাসনাত ভিলা',
      flatRentAmount: 8500.00,
      electricityUnitPrice: 7.50,
      gasbill: 600,
      waterBill: 0.00,
      flats: [], //flatList,
      otherExpences: [],

      //FLATS AND OTHERBILL IS INITIALLISED IN CONSTRUCTOR
    )
  ];
}

List<OthersExpence> othersList = [
  OthersExpence(purpose: 'ময়লা', amount: 100.00),
  OthersExpence(purpose: 'সিঁড়ি মোছা', amount: 125.00),
];

List<Flat> flatList = [
  Flat(
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
              currentUnitofElectricity: 7458.00, //random electricity unit
              transactions: [
                Transaction(
                  transactionDate: DateTime.parse("2022-04-03"),
                  takenAmount: 8000.00,
                  isAdvance: true,
                ),
              ],
            ),
            MonthDetails(
              monthNmae: 'May',
              currentUnitofElectricity: 7338.39, //first month usage is zero
              transactions: [
                Transaction(
                  transactionDate: DateTime.parse("2022-05-07"),
                  takenAmount: 8450.00,
                ),
              ],
            ),
            MonthDetails(
              monthNmae: 'Jun',
              currentUnitofElectricity: 7450.00,
              transactions: [
                Transaction(
                  transactionDate: DateTime.parse("2022-06-06"),
                  takenAmount: 8760.00,
                ),
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
              currentUnitofElectricity: 7458.00, //random electricity unit
              transactions: [
                Transaction(
                  transactionDate: DateTime.parse("2022-11-05"),
                  takenAmount: 16000.00,
                  isAdvance: true,
                ),
              ],
            ),
            MonthDetails(
              monthNmae: 'Dec',
              currentUnitofElectricity: 7338.39,
              transactions: [
                Transaction(
                  transactionDate: DateTime.parse("2022-12-10"),
                  takenAmount: 8450.00,
                ),
              ],
            ),
          ],
        ),

        //2nd year
        Year(yearNo: 2023, months: <MonthDetails>[
          MonthDetails(
            monthNmae: 'Jan',
            currentUnitofElectricity: 7450.00,
            transactions: [
              Transaction(
                transactionDate: DateTime.parse("2022-10-04"),
                takenAmount: 8760.00,
              ),
            ],
          ),
          MonthDetails(
            monthNmae: 'Feb',
            currentUnitofElectricity: 7450.00,
            transactions: [
              Transaction(
                transactionDate: DateTime.parse("2022-10-04"),
                takenAmount: 8760.00,
              ),
            ],
          ),
          MonthDetails(
            monthNmae: 'Mar',
            currentUnitofElectricity: 7450.00,
            transactions: [
              Transaction(
                transactionDate: DateTime.parse("2022-10-04"),
                takenAmount: 8760.00,
              ),
            ],
          ),
        ])
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
              currentUnitofElectricity: 7458.00, //random electricity unit
              transactions: [
                Transaction(
                  transactionDate: DateTime.parse("2022-08-05"),
                  takenAmount: 16000.00,
                  isAdvance: true,
                ),
              ],
            ),
            MonthDetails(
              monthNmae: 'Sep',
              currentUnitofElectricity: 7338.39,
              transactions: [
                Transaction(
                  transactionDate: DateTime.parse("2022-09-10"),
                  takenAmount: 8450.00,
                ),
              ],
            ),
            MonthDetails(
              monthNmae: 'Oct',
              currentUnitofElectricity: 7450.00,
              transactions: [
                Transaction(
                  transactionDate: DateTime.parse("2022-10-02"),
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
