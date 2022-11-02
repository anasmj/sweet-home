import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/mvvm/models/flat_model.dart';
import 'package:sweet_home/mvvm/utils/formatter.dart';
import 'package:sweet_home/mvvm/view_models/flat_view_model.dart';
import 'package:sweet_home/mvvm/views/shared_widgets/option_tile.dart';

// ignore: must_be_immutable
class MeterReadingList extends StatelessWidget {
  MeterReadingList({super.key, required this.flat});
  Flat flat;
  // String currentReadingString = 'দেওয়া নেই';
  // String previousReadingString = 'দেওয়া নেই';
  bool isCurrentReadingNull = true;
  bool isPreviousReadingNull = true;
  DateTime currentDate = DateTime.now();
  GlobalKey<FormState> readingKey = GlobalKey();
  final previousController = TextEditingController();
  final currentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    FlatViewModel viewModel = context.watch<FlatViewModel>();
    String? previousMeterDateString =
        flat.previousMeterReadingUpdateTime != null
            ? Formatter().appDateTime(flat.previousMeterReadingUpdateTime!)
            : '';
    String? presentMeterDateString = flat.presentMeterReadingUpdateTime != null
        ? Formatter().appDateTime(flat.presentMeterReadingUpdateTime!)
        : '';

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        OptionTile(
          isThreeLine: true,
          flatViewModel: viewModel,
          customIcon:
              flat.presentMeterReading == null ? pendingIcon() : tickIcon(),
          sheetTitle: 'বর্তমান রিডিং',
          subTitle: flat.presentMeterReading != null
              ? '${Formatter.toBn(value: flat.presentMeterReading, includeSymbol: false)}\n$presentMeterDateString'
              : 'দেওয়া নেই',
          isDouble: true,
          validationFunciton: (String? value) {
            if (value!.isEmpty) return 'তথ্যটি দেয়া হয়নি';
            if (double.tryParse(value) == null) return 'তথ্যটি সঠিক নয়';
            if (double.parse(value) <= 0) return 'তথ্যটি সঠিক নয়';
            if (flat.previousMeterReading != null) {
              if (double.parse(value) <= flat.previousMeterReading!) {
                return 'পূর্বের  রিডিং এর চেয়ে কম';
              }
            }
            return null;
          },
        ),
        OptionTile(
          flatViewModel: viewModel,
          isThreeLine: true,
          customIcon:
              flat.previousMeterReading == null ? pendingIcon() : tickIcon(),
          sheetTitle: 'পূর্বের রিডিং',
          subTitle: flat.previousMeterReading != null
              ? '${Formatter.toBn(value: flat.previousMeterReading, includeSymbol: false)}\n$previousMeterDateString'
              : 'দেওয়া নেই',
          isDouble: true,
          validationFunciton: (String? value) {
            if (value!.isEmpty) return 'তথ্যটি দেয়া হয়নি';
            if (double.tryParse(value) == null) return 'তথ্যটি সঠিক নয়';
            if (double.parse(value) <= 0) return 'তথ্যটি সঠিক নয়';
            if (flat.presentMeterReading != null) {
              if (double.parse(value) > flat.presentMeterReading!) {
                return 'বর্তমান রিডিং এর চেয়ে বেশি';
              }
              if (double.parse(value) == flat.presentMeterReading!) {
                return 'বর্তমান রিডিং এর সমান';
              }
            }
            return null;
          },
        ),
      ],
    );
  }

  Icon tickIcon() =>
      const Icon(Icons.check_circle, color: Colors.green, size: 22);
  Icon pendingIcon() => const Icon(FontAwesomeIcons.circleQuestion,
      color: Colors.orange, size: 22);
}
