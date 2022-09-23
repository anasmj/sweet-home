import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/providers/monthly_record_provider.dart';
import 'package:sweet_home/view/screens/renter_opening_page/components/bottom_button.dart';
import 'package:sweet_home/view/screens/renter_opening_page/monthly_expence_page/components/electricity_table.dart';
import 'package:sweet_home/providers/flat_info_provider.dart';
import 'package:sweet_home/view/app_widgets.dart';
import '../../../../../models/flat_model.dart';
import 'package:sweet_home/view/resources/app_icons.dart';

// ignore: must_be_immutable
class MonthlyExpenceTable extends StatelessWidget {
  const MonthlyExpenceTable({super.key});

  @override
  Widget build(BuildContext context) {
    //*use this to show data .
    //*after confirmed by user, make a month detail object which will
    //*be later used to show previoufs month details
    Flat? currentFlat =
        Provider.of<CurrentFlatInfoProvider>(context).selectedFlat;
    double? meterReading = context.watch<MonthlyRecordProvider>().meterReading;

    TextTheme textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            getPurposeTitle(titleIcon: AppIcons.homeUrl, title: 'ভাড়া'),
            Text('৳ ${currentFlat!.flatRentAmount.toString()}'),
            // Text(Bill.setRenter(renter: renter).rent), //! THIS WILL NEEDED TO SHOW ALL MONTHE DETAIL OBJECTS
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            getPurposeTitle(titleIcon: AppIcons.flameUrl, title: 'গ্যাস'),
            Text('৳ ${currentFlat.flatGasBill.toStringAsFixed(1)}'),
            // Text(Bill.setRenter(renter: renter).gasBill)
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            getPurposeTitle(titleIcon: AppIcons.waterTapUrl, title: 'পানি'),
            Text('৳ ${currentFlat.flatWaterBill.toStringAsFixed(1)}'),
            // Text(Bill.setRenter(renter: renter).waterBill),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            getPurposeTitle(
              titleIcon: AppIcons.electricityUrl,
              title: 'বিদ্যুৎ',
              widget: meterReading == null
                  ? IconButton(
                      onPressed: () async {
                        await AppWidget.showElectricityUnitDialog(
                            context: context);
                      },
                      icon: const Icon(
                        Icons.info_outline,
                        size: 16,
                        color: Colors.red,
                      ),
                    )
                  : const SizedBox(),
            ),

            Text('৳ 923'),

            // Text(
            //     Bill.setRenter(renter: currentFlat.renter!)
            //         .getElectricBill
            //         .toString(),
            //     CalculateBill.setRenter(renter: renter).getElectricBill,
            //     ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 40.0),
          child: ElectricityTable(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            getPurposeTitle(titleIcon: AppIcons.otherUrl, title: 'অন্যান্য'),
            // Text(CalculateBill.setRenter(renter: renter).sumOfOtherBills)

            Text('৳ 3232'),
          ],
        ),
        // Padding(
        //   padding: const EdgeInsets.only(left: 40.0),
        //   child: OthersTable(
        //     othersList: CalculateBill.setRenter(renter: renter)
        //         .otherExpenceListForThisMonth,
        //   ),
        // ),
        transactionDivider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "মোট",
              style: textTheme.subtitle1!.copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
              '৳ 34221',
              // CalculateBill.setRenter(renter: renter)
              //     .totalBill
              //     .toStringAsFixed(1),
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
              '৳ 3434(tst)',
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
              '৳ 2400',
              style: textTheme.subtitle1!.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Center(child: BottomButton(text: 'হিসাবটি নিশ্চিত করি')),
        ),
        const SizedBox(
          height: 70,
        ),
      ]
          .map((e) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: e))
          .toList(),
    );
  }

  Widget getPurposeTitle(
          {required String titleIcon, String title = '', Widget? widget}) =>
      Row(
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
          ),
          widget ?? const SizedBox()
        ],
      );

  Widget transactionDivider() => Divider(
        thickness: 2,
        color: Colors.black.withOpacity(0.6),
      );
}
