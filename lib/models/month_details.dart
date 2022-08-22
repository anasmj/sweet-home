import 'package:sweet_home/models/transaction_model.dart';
import 'package:sweet_home/providers/home_provider.dart';
import 'others_model.dart';

class MonthDetails {
  final String monthNmae; //? it is needed ?
  bool isNotified;
  int? renterFlatRent;

  double? electricityUnitPrice;
  double readingOfElecctricMeter;

  double? gasbill;
  double? myWaterBill;
  List<OthersExpence>? myOthersExpences;
  List<Transaction>? transactions = [];

  MonthDetails({
    required this.monthNmae,
    required this.readingOfElecctricMeter,

    // this.electricityUnitPrice, //*Always take global value from HmeProvider with help of constructor

    //values that can vary flat to flat
    // this.renterFlatRent, //always take value from corresponding flat
    this.myOthersExpences,
    this.gasbill,
    this.isNotified = false,
    this.transactions,
  }) {
    //CurrentFlatInfoProvider usersFlat = CurrentFlatInfoProvider();

    // renterFlatRent ??=
    //     usersFlat.flatRentAmount; //homeProvider.globalRentAmount;

    // gasbill ??= usersFlat.flatGasBill;
    // myWaterBill ??= usersFlat.flatWaterBill;
    // electricityUnitPrice = usersFlat.electricityUnitPrice;
    // myOthersExpences ??= usersFlat.flatOtherExpences;
    // transactions ??= []; //later transaction will be added to the list

    HomeProvider homeProvider = HomeProvider();

    renterFlatRent ??=
        HomeProvider().globalRentAmount; //homeProvider.globalRentAmount;
    gasbill ??= homeProvider.globalGasbill;
    myWaterBill ??= homeProvider.globalWaterBill;
    electricityUnitPrice = homeProvider.electricityUnitPrice;
    myOthersExpences ??= homeProvider.globalOtherExpences;
    transactions ??= []; //later transaction will be added to the list
  }
}
