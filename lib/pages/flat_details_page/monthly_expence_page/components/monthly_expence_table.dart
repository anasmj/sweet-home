import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rent_home/pages/app_icons.dart';
import 'package:rent_home/pages/flat_details_page/monthly_expence_page/components/electricity_table.dart';
import 'package:rent_home/pages/flat_details_page/monthly_expence_page/components/others_table.dart';
import '../../../../models/month_details.dart';
import '../../../../models/renter.dart';
import '../../../../models/year.dart';

class MonthlyExpenceTable extends StatelessWidget {
  MonthlyExpenceTable({required this.renter, super.key});
  Renter renter;

  @override
  Widget build(BuildContext context) {
    Year currentYear =
        renter.records[renter.records.length - 1]; //last element of List<year>
    MonthDetails currentMonth = currentYear.months[
        currentYear.months.length - 1]; //last element of List<MonthDetails>
    // print(flat.gasbill.toString());
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                purposeTitle(titleIcon: AppIcons().homeUrl, title: 'ভাড়া'),
                //Text('hello')
                Text(currentMonth.myFlatRent.toString())
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                purposeTitle(titleIcon: AppIcons().flameUrl, title: 'গ্যাস'),
                Text(currentMonth.gasbill.toString())
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                purposeTitle(titleIcon: AppIcons().waterTapUrl, title: 'পানি'),
                Text(currentMonth.myWaterBill.toString())
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                purposeTitle(
                    titleIcon: AppIcons().electricityUrl, title: 'বিদ্যুৎ'),
                Text('1200')
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
                const Text('1200')
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40.0),
              child: OthersTable(
                othersList: currentMonth.myOthersExpences,
              ),
            ),
            transactionDivider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("মোট"),
                Text('2400'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("আগের বকেয়া"),
                Text('230'),
              ],
            ),
            transactionDivider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("সর্বমোট"),
                Text('2400'),
              ],
            ),
            const SizedBox(),
          ]
              .map((e) => Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: e,
                  ))
              .toList(),
        ),
      ),
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
            style: TextStyle(fontSize: 18),
          )
        ],
      );

  Widget transactionDivider() => Divider(
        thickness: 2,
        color: Colors.black.withOpacity(0.6),
      );
}
