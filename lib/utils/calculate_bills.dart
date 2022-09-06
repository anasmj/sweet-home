import 'package:sweet_home/models/month_details.dart';
import 'package:sweet_home/models/others_model.dart';

import '../models/renter.dart';
import '../models/year.dart';

// PROVIDES ALL KIND OF BILLING INFORMATION
class CalculateBill {
  Renter renter;

  late MonthDetails previousMonth;
  late MonthDetails currentMonth;
  late double electricUnitPrice;
  late double usedUnit;

  double? electricBill = 0;

  CalculateBill.setRenter({required this.renter}) {
    Year currentYear =
        renter.records[renter.records.length - 1]; //last element of List<year>
    currentMonth = currentYear.months[currentYear.months.length - 1];
    previousMonth = currentYear.months[currentYear.months.length - 2];
  }

  MonthDetails get getCurrentMonth => currentMonth;

  //methods called from electricity table
  String get previousMonthReading =>
      previousMonth.readingOfElecctricMeter.toStringAsFixed(1);

  String get currentMonthReading =>
      currentMonth.readingOfElecctricMeter.toStringAsFixed(1);

  String get usedUnitOfElectricity => (currentMonth.readingOfElecctricMeter -
          previousMonth.readingOfElecctricMeter)
      .toStringAsFixed(1);

  String get rent => currentMonth.renterFlatRent.toString();
  String get gasBill => currentMonth.gasbill.toString();
  String get waterBill => currentMonth.myWaterBill.toString();
  String get getElectricBill {
    electricBill = (currentMonth.readingOfElecctricMeter -
            previousMonth.readingOfElecctricMeter) *
        currentMonth.electricityUnitPrice!;
    return electricBill!.toStringAsFixed(1);
  }

  List<OthersExpence> get otherExpenceListForThisMonth =>
      currentMonth.myOthersExpences!;

  //calculate other expences
  String get sumOfOtherBills {
    double sum = 0;
    if (currentMonth.myOthersExpences != null) {
      for (var element in currentMonth.myOthersExpences!) {
        sum += element.amount;
      }
      return sum.toStringAsFixed(1);
    } else {
      return '';
    }
  }

  //TOTAL
  double get totalBill {
    double total = 0;

    total = double.parse(rent) +
        double.parse(gasBill) +
        double.parse(waterBill) +
        double.parse(getElectricBill) +
        double.parse(sumOfOtherBills);

    return total;
  }

  //due

  //grand total

}
