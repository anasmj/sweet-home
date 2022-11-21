import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/mvvm/providers/theme_provider.dart';
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
  String presentDate = Formatter.toYearMonth(DateTime.now());
  FlatContainer({required this.flat, super.key});
  bool showPreviousReadingAlert = false;
  bool showPresentReadingAlert = false;

  Widget getMeterReadingMsg(Flat falt) {
    if (showPreviousReadingAlert) {
      return MeterImage(meterIndicatorType: MeterIndicatorType.previousReading);
    }
    if (showPresentReadingAlert) {
      return MeterImage(meterIndicatorType: MeterIndicatorType.currentReading);
    }
    return const SizedBox.shrink();
  }

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

  Widget noPreviousReadingText = Row(
    children: const [
      Icon(
        Icons.info_outline_rounded,
        color: Colors.red,
        size: 16,
      ),
      SizedBox(width: 4),
      Text(
        'পূর্বের রিডিং ঠিক নেই',
        style: TextStyle(color: Colors.red),
      )
    ],
  );

  Widget noCurrentReadingText = Row(
    children: const [
      Icon(
        Icons.info_outline_rounded,
        color: Colors.red,
        size: 16,
      ),
      SizedBox(width: 4),
      Text(
        'বর্তমান রিডিং ঠিক নেই',
        style: TextStyle(color: Colors.red),
      )
    ],
  );

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
    if (flat.presentMeterReading == null) {
      showPresentReadingAlert = true;
    }
    if (flat.previousMeterReading == null) {
      showPreviousReadingAlert = true;
    }
    if (flat.renter != null) {
      if (Formatter.toYearMonth(flat.renter!.entryDate) ==
          Formatter.toYearMonth(DateTime.now())) {
        showPresentReadingAlert = false;
      }
    }
    bool isDark = context.watch<ThemeProvider>().isDarkMode;
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
            ? showPreviousReadingAlert
                ? Positioned(
                    left: 10,
                    bottom: -30,
                    child: noPreviousReadingText,
                  )
                : showPresentReadingAlert
                    ? Positioned(
                        left: 10,
                        bottom: -30,
                        child: noCurrentReadingText,
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
