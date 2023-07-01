import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sweet_home/src/constants/constants.dart';
import 'package:sweet_home/src/model/flat.dart';
import 'package:sweet_home/src/utils/formatter.dart';

import 'flat.container.components.dart';

// ignore: must_be_immutable
class FlatContainer extends StatelessWidget {
  Flat flat;
  String presentDate = Formatter.toYearMonth(DateTime.now());
  FlatContainer({
    required this.flat,
    this.onFlatTap,
    this.onFlatLongPress,
    super.key,
  });
  final VoidCallback? onFlatTap, onFlatLongPress;
  bool showPreviousReadingAlert = true;
  bool showPresentReadingAlert = true;

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

  // Future<void> openRenterPage(BuildContext context) async {
  //   Provider.of<SelectedFlatProvider>(context, listen: false).setSelectedFlat =
  //       flat;
  //   // await context.read<FlatViewModel>().getLastMonthRsecord();
  //   Navigator.of(context).push(
  //     MaterialPageRoute(
  //       builder: ((builder) => const RenterOpeningPage()),
  //     ),
  //   );
  // }

  // void addRenter(BuildContext context) {
  //   Provider.of<SelectedFlatProvider>(context, listen: false).setSelectedFlat =
  //       flat;
  //   AppRoute.newRenterStepper(
  //     context: context,
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    showPresentReadingAlert = flat.presentMeterReading == null;
    showPreviousReadingAlert = flat.previousMeterReading == null;

    if (flat.renter?.entryDate != null) {
      if (Formatter.toYearMonth(flat.renter!.entryDate!) ==
          Formatter.toYearMonth(DateTime.now())) {
        showPresentReadingAlert = false;
      }
    }
    // bool isDark = context.watch<ThemeProvider>().isDarkMode;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        InkWell(
          onTap: onFlatTap,
          onLongPress: onFlatLongPress,
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
                    SvgPicture.asset(
                      AssetPath.personAddUrl,
                      height: 40,
                    ),

                    //BOTTOM INFORMATION ABOUT FLAT
                    Footer(renter: flat.renter)
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
        const Positioned(
          top: -20,
          child: ProfileAvatar(),
        ),
      ],
    );
  }
}
