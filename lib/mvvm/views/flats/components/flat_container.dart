import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/mvvm/utils/enums.dart';
import 'package:sweet_home/mvvm/utils/formatter.dart';
import 'package:sweet_home/mvvm/views/flats/components/meter_image.dart';
import 'package:sweet_home/mvvm/views/flats/components/profile_avatar.dart';
import 'package:sweet_home/mvvm/views/renter_opening_page/renter_opening_page.dart';
import '../../../models/flat_model.dart';
import '../../../providers/selected_flat_provider.dart';
import '../../../../prev/utils/routes.dart';
import '../../app_widgets.dart';
import '../../resources/app_icons.dart';
import 'flat_options.dart';

// ignore: must_be_immutable
class FlatContainer extends StatelessWidget {
  Flat flat;
  String presentDate = Formatter.makeId(DateTime.now());
  FlatContainer({required this.flat, super.key});

  Widget getMeterReadingMsg(Flat falt) {
    if (flat.presentMeterReading == null) {
      return MeterImage(meterIndicatorType: MeterIndicatorType.previousReading);
    }
    if (flat.presentMeterReadingUpdateTime == null) {
      return MeterImage(meterIndicatorType: MeterIndicatorType.currentReading);
    }
    if (Formatter.makeId(flat.presentMeterReadingUpdateTime!) !=
        Formatter.makeId(DateTime.now())) {
      return MeterImage(meterIndicatorType: MeterIndicatorType.currentReading);
    }
    return const SizedBox.shrink();
  }
  //trying another way
  // Widget getMeterReadingMsg(Flat falt) {
  //   if (flat.previousMeterReading != null) {
  //     if (flat.confirmDate == null) return const SizedBox.shrink();

  //     if (Formatter.makeId(flat.confirmDate!) == presentDate) {
  //       return const SizedBox.shrink();
  //     } else {
  //       return MeterImage(
  //           meterIndicatorType: MeterIndicatorType.currentReading);
  //     }
  //   } else {
  //     return MeterImage(meterIndicatorType: MeterIndicatorType.previousReading);
  //   }
  // }

  Widget footer(Flat flat) {
    if (flat.renter == null) {
      return const Padding(
        padding: EdgeInsets.only(bottom: 10.0),
        child: Text(
          'খালি আছে',
          style: TextStyle(fontSize: 18),
        ),
      );
    }
    return Builder(builder: (context) {
      return ListTile(
        title: Text(
          flat.renter!.renterName,
          maxLines: 1,
          overflow: TextOverflow.fade,
          softWrap: true,
        ),
        subtitle: flat.renter != null
            ? Text(
                ' পাবো ৳ -',
                style: Theme.of(context).textTheme.titleSmall,
              )
            : const SizedBox.shrink(),

        // subtitle: Text(flat.renter != null
        //     ? '${CustomFormatter().monthYear(flat.renter!.entryDate!)} থেকে আছেন'
        //     : ''),
      );
    });
  }

  Row noPreviousReadingText() {
    return Row(
      children: const [
        Icon(
          Icons.info_outline_rounded,
          color: Colors.red,
          size: 16,
        ),
        SizedBox(width: 4),
        Text(
          'পূর্বের রিডিং দেয়া নেই',
          style: TextStyle(color: Colors.red),
        )
      ],
    );
  }

  Row noCurrentReadingText() {
    return Row(
      children: const [
        Icon(
          Icons.info_outline_rounded,
          color: Colors.red,
          size: 16,
        ),
        SizedBox(width: 4),
        Text(
          'বর্তমান রিডিং আপডেট করুন',
          style: TextStyle(color: Colors.red),
        )
      ],
    );
  }

  SvgPicture personAddIcon(bool isDark) {
    return SvgPicture.asset(
      AppIcons.personAddUrl,
      height: 40,
      // width: 90,
      color: isDark
          ? Colors.white.withOpacity(0.6)
          : Colors.black.withOpacity(0.6),
    );
  }

  Future<void> openRenterPage(BuildContext context) async {
    Provider.of<SelectedFlatProvider>(context, listen: false).setSelectedFlat =
        flat;
    // await context.read<FlatViewModel>().getLastMonthRsecord();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: ((builder) => const RenterOpeningPage()),
      ),
    );
  }

  void addRenter(BuildContext context) {
    Provider.of<SelectedFlatProvider>(context, listen: false).setSelectedFlat =
        flat;
    AppRoute.newRenterStepper(
      context: context,
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = false;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        InkWell(
          onTap: () async {
            flat.renter == null ? addRenter(context) : openRenterPage(context);
          },
          onLongPress: () {
            Provider.of<SelectedFlatProvider>(context, listen: false)
                .setSelectedFlat = flat;

            AppWidget.getModalSheet(
                context: context, modalSheetContent: const FlatOptions());
          },
          // flatOptionModalSheet(context: context, isDark: isDark),
          child: Material(
            //shadowing
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 3.0,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Theme.of(context).primaryColor,
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          flat.flatName,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    flat.renter == null
                        ? personAddIcon(isDark)
                        : getMeterReadingMsg(flat),

                    //BOTTOM INFORMATION ABOUT FLAT
                    footer(flat),
                  ],
                ),
              ),
            ),
          ),
        ),
        flat.renter != null
            ? flat.previousMeterReading == null
                ? Positioned(
                    left: 10,
                    bottom: -30,
                    child: noPreviousReadingText(),
                  )
                : flat.presentMeterReading == null
                    ? Positioned(
                        left: 10,
                        bottom: -30,
                        child: noCurrentReadingText(),
                      )
                    : const SizedBox.shrink()
            : const SizedBox.shrink(),
        Positioned(
          top: -20,
          child: ProfileAvatar(isDark: isDark),
        ),
      ],
    );
  }
}
