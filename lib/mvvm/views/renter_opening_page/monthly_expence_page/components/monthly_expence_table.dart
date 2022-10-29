import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/mvvm/providers/selected_flat_provider.dart';
import 'package:sweet_home/mvvm/utils/enums.dart';
import 'package:sweet_home/mvvm/utils/formatter.dart';
import 'package:sweet_home/mvvm/view_models/renter_view_model.dart';
import 'package:sweet_home/mvvm/views/renter_opening_page/monthly_expence_page/components/meter_reading_dialog.dart';
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
    Flat? flat = Provider.of<SelectedFlatProvider>(context).selectedFlat;

    double? currentReading = flat?.currentMeterReading;
    double? prevReading = flat?.previousMeterReading;

    TextTheme textTheme = Theme.of(context).textTheme;
    if (flat == null) {
      return const SizedBox.shrink();
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          flatRentRow(flat),
          gasBillRow(flat),
          waterBillRow(flat),
          getElectricityRow(prevReading, context, currentReading),
          const Padding(
            padding: EdgeInsets.only(left: 40.0),
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
          TotaBilllRow(textTheme: textTheme),
          DueRow(textTheme: textTheme, account: flat.renter!.dueAmount),
          transactionDivider(),
          GrandTotalRow(textTheme: textTheme),
          Visibility(
            visible: false,
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Center(child: confirmButton),
            ),
          ),
          const SizedBox(
            height: 70,
          ),
        ]
            .map((e) => Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: e))
            .toList(),
      );
    }
  }

  final Widget confirmButton = Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        '* হিসাবটি আপডেট করতে ক্লিক করুন',
        style: TextStyle(color: Colors.red.shade700),
      ),
      // const SizedBox(height: ),
      ConfirmCalculationButton(text: 'হিসাবটি নিশ্চিত করি'),
    ],
  );
  Row flatRentRow(Flat flat) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        getPurposeTitle(titleIcon: AppIcons.homeUrl, title: 'ভাড়া'),
        Text(
          Formatter.toBn(value: flat.flatRentAmount),
          style: TextStyle(fontSize: _fontSize),
        ),
      ],
    );
  }

  Row gasBillRow(Flat flat) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        getPurposeTitle(titleIcon: AppIcons.flameUrl, title: 'গ্যাস'),
        Text(
          Formatter.toBn(value: flat.flatGasBill),
          style: TextStyle(fontSize: _fontSize),
        ),
      ],
    );
  }

  Row waterBillRow(Flat flat) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        getPurposeTitle(titleIcon: AppIcons.waterTapUrl, title: 'পানি'),
        Text(
          Formatter.toBn(value: flat.flatWaterBill),
          style: TextStyle(fontSize: _fontSize),
        ),
      ],
    );
  }

  Row getElectricityRow(
      double? prevReading, BuildContext context, double? currentReading) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        getPurposeTitle(
          titleIcon: AppIcons.electricityUrl,
          title: 'বিদ্যুৎ',
          widget: prevReading == null
              ? IconButton(
                  onPressed: () async {
                    await showElectricityUnitDialog(
                        context: context, unitType: UnitType.previous);
                    // await noPrevReadingAlert(context);
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
                        await showElectricityUnitDialog(
                            context: context, unitType: UnitType.present);
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
          Formatter.toBn(value: context.watch<RenterViewModel>().electricBill),
          style: TextStyle(fontSize: _fontSize),
        ),
      ],
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

class TotaBilllRow extends StatelessWidget {
  const TotaBilllRow({
    super.key,
    required this.textTheme,
  });

  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "মোট",
          style: textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
        ),
        Text(
          Formatter.toBn(
              value: context.watch<RenterViewModel>().totalBill ?? 0.0),
          style: textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class GrandTotalRow extends StatelessWidget {
  const GrandTotalRow({
    super.key,
    required this.textTheme,
  });

  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "সর্বমোট",
          style: textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w500),
        ),
        Text(
          Formatter.toBn(
              value: context.watch<RenterViewModel>().totalBill ?? 0),
          style: textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

// ignore: must_be_immutable
class DueRow extends StatelessWidget {
  DueRow({super.key, required this.textTheme, required this.account});

  final TextTheme textTheme;
  double account;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "আগের বকেয়া",
          style: textTheme.titleMedium,
        ),
        Text(
          Formatter.toBn(value: account.abs()),
          style: textTheme.titleMedium!
              .copyWith(fontWeight: FontWeight.bold, color: Colors.red[900]),
        ),
      ],
    );
  }
}
