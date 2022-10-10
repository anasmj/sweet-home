import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/mvvm/providers/bills_provider.dart';
import 'package:sweet_home/mvvm/view_models/selected_flat_view_model.dart';
import 'package:sweet_home/mvvm/views/app_widgets.dart';
import 'package:sweet_home/mvvm/views/resources/app_icons.dart';

import '../../../../../../mvvm/models/flat_model.dart';

import '../../components/confirm_calculation_button.dart';
import 'electricity_table.dart';

// ignore: must_be_immutable
class MonthlyExpenceTable extends StatefulWidget {
  const MonthlyExpenceTable({super.key});

  @override
  State<MonthlyExpenceTable> createState() => _MonthlyExpenceTableState();
}

class _MonthlyExpenceTableState extends State<MonthlyExpenceTable> {
  get home => null;
  final double _fontSize = 16;

  @override
  Widget build(BuildContext context) {
    //*use this to show data .
    //*after confirmed by user, make a month detail object which will
    //*be later used to show previoufs month details
    Flat? flat = Provider.of<SelectedFlatVuewModel>(context).selectedFlat;
    double? currentReading = context
        .watch<SelectedFlatVuewModel>()
        .selectedFlat!
        .currentMeterReading;
    double? prevReading = context
        .watch<SelectedFlatVuewModel>()
        .selectedFlat!
        .previousMeterReading;

    TextTheme textTheme = Theme.of(context).textTheme;
    return flat == null
        ? const SizedBox()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  getPurposeTitle(titleIcon: AppIcons.homeUrl, title: 'ভাড়া'),
                  Text(
                    '৳ ${flat.flatRentAmount.toString()}',
                    style: TextStyle(fontSize: _fontSize),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  getPurposeTitle(titleIcon: AppIcons.flameUrl, title: 'গ্যাস'),
                  Text(
                    '৳ ${flat.flatGasBill.toStringAsFixed(1)}',
                    style: TextStyle(fontSize: _fontSize),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  getPurposeTitle(
                      titleIcon: AppIcons.waterTapUrl, title: 'পানি'),
                  Text(
                    '৳ ${flat.flatWaterBill.toStringAsFixed(1)}',
                    style: TextStyle(fontSize: _fontSize),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  getPurposeTitle(
                    titleIcon: AppIcons.electricityUrl,
                    title: 'বিদ্যুৎ',
                    widget: prevReading == null
                        ? IconButton(
                            onPressed: () async {
                              await noPrevReadingAlert(context);
                            },
                            icon: const Icon(
                              Icons.info_outline,
                              size: 16,
                              color: Colors.red,
                            ),
                          )
                        : currentReading == null
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
                  Text(
                    '৳ ${context.watch<BillsProvider>().electricBill.toStringAsFixed(1)}',
                    style: TextStyle(fontSize: _fontSize),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40.0),
                child: ElectricityTable(),
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     getPurposeTitle(titleIcon: AppIcons.otherUrl, title: 'অন্যান্য'),
              //     // Text(CalculateBill.setRenter(renter: renter).sumOfOtherBills)

              //     Text('৳ 3232'),
              //   ],
              // ),
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
                    style: textTheme.subtitle1!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '৳ ${context.watch<BillsProvider>().totalBill.toString()}',
                    // CalculateBill.setRenter(renter: renter)
                    //     .totalBill
                    //     .toStringAsFixed(1),
                    style: textTheme.subtitle1!
                        .copyWith(fontWeight: FontWeight.bold),
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
                    '৳ 0',
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
                    style: textTheme.subtitle1!
                        .copyWith(fontWeight: FontWeight.w500),
                  ),
                  Text(
                    '৳ ${context.watch<BillsProvider>().totalBill.toString()}',
                    style: textTheme.subtitle1!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Center(
                    child:
                        ConfirmCalculationButton(text: 'হিসাবটি নিশ্চিত করি')),
              ),
              const SizedBox(
                height: 70,
              ),
            ]
                .map((e) => Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: e))
                .toList(),
          );
  }

  Future<dynamic> noPrevReadingAlert(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Row(
                children: const [
                  Icon(
                    Icons.info_outline,
                    color: Colors.red,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text('পূর্বের ইউনিট ঠিক করা হয়নি'),
                ],
              ),
            ));
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
