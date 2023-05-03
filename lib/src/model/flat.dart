import 'package:sweet_home/src/model/renter.dart';
import '../utils/db.fields.dart';
part 'flat.ext.dart';

class Flat {
  //detail info of flat
  String flatName;
  // if not given, taken global value from HomeProvider class
  int flatRentAmount;

  Renter? renter;
  //These values can vary flat to flat. if not given, take global value from HomeProvider
  //every month these values will be used in MonthDetails class to determine bills
  //for that month.
  int flatGasBill, flatWaterBill, monthlyDue;
  double? presentMeterReading;
  double? previousMeterReading;
  DateTime? previousMeterReadingUpdateTime,
      presentMeterReadingUpdateTime,
      confirmDate;

  // List<ServiceCharge>? serviceCharges;

  Flat({
    this.flatName = '',
    this.renter,
    this.flatRentAmount = 0,
    this.flatGasBill = 0,
    this.flatWaterBill = 0,
    this.presentMeterReading,
    this.previousMeterReading,
    this.previousMeterReadingUpdateTime,
    this.presentMeterReadingUpdateTime,
    this.monthlyDue = 0,
    this.confirmDate,
    // this.serviceCharges,
  });
}
