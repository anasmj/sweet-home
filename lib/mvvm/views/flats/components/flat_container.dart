import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/mvvm/utils/enums.dart';
import 'package:sweet_home/mvvm/views/flats/components/meter_image.dart';
import 'package:sweet_home/mvvm/views/flats/components/profile_avatar.dart';
import 'package:sweet_home/mvvm/views/renter_opening_page/renter_opening_page.dart';
import '../../../models/flat_model.dart';
import '../../../providers/selected_flat_view_model.dart';
import '../../../../prev/utils/routes.dart';
import '../../app_widgets.dart';
import '../../resources/app_icons.dart';
import 'flat_options.dart';

// ignore: must_be_immutable
class FlatContainer extends StatelessWidget {
  Flat flat;
  FlatContainer({required this.flat, super.key});

  Widget widgetForRenter(Flat falt) {
    if (flat.previousMeterReading != null) {
      if (flat.currentMeterReading != null) {
        // all readings are okay
        return const SizedBox.shrink();
      }
      return MeterImage(meterIndicatorType: MeterIndicatorType.currentReading);
    }
    return MeterImage(meterIndicatorType: MeterIndicatorType.previousReading);
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
                'পাবো ৳ -',
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
          'পূর্বের রিডিং ঠিক নেই',
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
          'বর্তমান রিডিং দেয়া হয়নি',
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

  @override
  Widget build(BuildContext context) {
    bool isDark = false;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        InkWell(
          onTap: () async {
            Provider.of<SelectedFlatVuewModel>(context, listen: false)
                .newSelectedFlat = flat;

            flat.renter == null
                ? AppRoute.newRenterStepper(
                    context: context,
                  )
                : Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: ((builder) => RenterOpeningPage()),
                    ),
                  );
          },
          onLongPress: () {
            Provider.of<SelectedFlatVuewModel>(context, listen: false)
                .newSelectedFlat = flat;
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
                        : widgetForRenter(flat),

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
                    left: 20,
                    bottom: -30,
                    child: noPreviousReadingText(),
                  )
                : flat.currentMeterReading == null
                    ? noCurrentReadingText()
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
