import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:rent_home/views/app_icons.dart';
import 'package:rent_home/views/flat_details_page/components/bottom_button.dart';
import 'package:rent_home/views/flat_details_page/monthly_expence_page/components/electricity_table.dart';
import 'package:rent_home/views/flat_details_page/monthly_expence_page/components/others_table.dart';
import 'package:rent_home/providers/flat_info_provider.dart';
import '../../../../models/renter.dart';
import '../../../../controllers/bills.dart';

class MonthlyExpenceTable extends StatelessWidget {
  MonthlyExpenceTable({required this.renter, super.key});
  Renter renter;

  @override
  Widget build(BuildContext context) {
    //*use this to show data .
    //*after confirmed by user, make a month detail object which will
    //*be later used to show previous month details
    CurrentFlatInfoProvider currentFlat =
        Provider.of<CurrentFlatInfoProvider>(context);

    TextTheme textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            purposeTitle(titleIcon: AppIcons().homeUrl, title: 'ভাড়া'),
            Text(currentFlat.flatRentAmount.toString()),
            // Text(Bill.setRenter(renter: renter).rent), //! THIS WILL NEEDED TO SHOW ALL MONTHE DETAIL OBJECTS
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            purposeTitle(titleIcon: AppIcons().flameUrl, title: 'গ্যাস'),
            Text(currentFlat.flatGasBill.toStringAsFixed(1)),
            // Text(Bill.setRenter(renter: renter).gasBill)
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            purposeTitle(titleIcon: AppIcons().waterTapUrl, title: 'পানি'),
            Text(currentFlat.flatWaterBill.toStringAsFixed(1)),
            // Text(Bill.setRenter(renter: renter).waterBill),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            purposeTitle(
                titleIcon: AppIcons().electricityUrl, title: 'বিদ্যুৎ'),
            Text(
              // Bill.setRenter(renter: currentFlat.renter!)
              //     .getElectricBill
              //     .toString(),
              Bill.setRenter(renter: renter).getElectricBill,
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 40.0),
          child: ElectricityTable(
            renter: renter,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            purposeTitle(titleIcon: AppIcons().otherUrl, title: 'অন্যান্য'),
            Text(Bill.setRenter(renter: renter).sumOfOtherBills)
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 40.0),
          child: OthersTable(
            othersList:
                Bill.setRenter(renter: renter).otherExpenceListForThisMonth,
          ),
        ),
        transactionDivider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "মোট",
              style: textTheme.subtitle1!.copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
              Bill.setRenter(renter: renter).totalBill.toStringAsFixed(1),
              style: textTheme.subtitle1!.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "আগের বকেয়া",
              style: textTheme.subtitle1,
            ),
            Text(
              '3434(tst)',
              style: textTheme.subtitle1!.copyWith(
                  fontWeight: FontWeight.bold, color: Colors.red[900]),
            ),
          ],
        ),
        transactionDivider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "সর্বমোট",
              style: textTheme.subtitle1!.copyWith(fontWeight: FontWeight.w500),
            ),
            Text(
              '2400',
              style: textTheme.subtitle1!.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Center(child: BottomButton(text: 'নিশ্চিত করছি ')),
        ),
        const SizedBox(
          height: 100,
        ),
      ]
          .map((e) => Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: e,
              ))
          .toList(),
    );
  }

  Widget purposeTitle({required String titleIcon, String title = ''}) => Row(
        children: [
          SvgPicture.asset(
            titleIcon,
            height: 22,
          ),
          const SizedBox(
            width: 8,
          ),
          Text(
            title,
            style: const TextStyle(fontSize: 18),
          )
        ],
      );

  Widget transactionDivider() => Divider(
        thickness: 2,
        color: Colors.black.withOpacity(0.6),
      );
}
