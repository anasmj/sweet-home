import 'package:rent_home/models/month_details.dart';

//USE THIS CLASS TO CALCULATE BILLS,
class Bill {
  MonthDetails previousMonth;
  MonthDetails currentMonth;
  double electricUnitPrice;

  double electricBill = 0;

  //named constructor to calculate electric Bill
  Bill.ElectricBill({
    required this.electricUnitPrice,
    required this.currentMonth,
    required this.previousMonth,
  });

  double calculateElectricBill() {
    double previousMonthReading = previousMonth.readingOfElecctricMeter;
    double currentMonthReading = currentMonth.readingOfElecctricMeter;
    electricBill =
        (currentMonthReading - previousMonthReading) * electricUnitPrice;
    electricBill = double.parse(electricBill.toStringAsFixed(1));

    return electricBill;
  }
}
