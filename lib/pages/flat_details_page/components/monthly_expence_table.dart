import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rent_home/pages/app_icons.dart';
import 'package:rent_home/pages/flat_details_page/components/electricity_table.dart';
import 'package:rent_home/pages/flat_details_page/components/others_table.dart';

class MonthlyExpenceTable extends StatelessWidget {
  const MonthlyExpenceTable({super.key});
  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    return Expanded(
      child: Container(
        // margin: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
        //padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
        // decoration: BoxDecoration(border: Border.all()),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //heading
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: const [
              //     Text('বিবরণ'),
              //     Text('টাকার পরিমাণ'),
              //   ],
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  purposeTitle(titleIcon: AppIcons().homeUrl, title: 'ভাড়া'),
                  Text('22500')
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  purposeTitle(titleIcon: AppIcons().flameUrl, title: 'গ্যাস'),
                  Text('500')
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  purposeTitle(
                      titleIcon: AppIcons().waterTapUrl, title: 'পানি'),
                  Text('800')
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

              const Padding(
                padding: EdgeInsets.only(left: 40.0),
                child: ElectricityTable(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  purposeTitle(
                      titleIcon: AppIcons().otherUrl, title: 'অন্যান্য'),
                  const Text('1200')
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(left: 40.0),
                child: OthersTable(),
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
