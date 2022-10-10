import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/mvvm/models/flat_model.dart';
import 'package:sweet_home/mvvm/view_models/selected_flat_view_model.dart';

class MeterReadingList extends StatelessWidget {
  const MeterReadingList({super.key});

  @override
  Widget build(BuildContext context) {
    Flat? flat = Provider.of<SelectedFlatVuewModel>(context).selectedFlat;
    String currentReadingString = 'দেওয়া নেই';
    String previousReadingString = 'দেওয়া নেই';
    bool isCurrentReadingNull = true;
    bool isPreviousReadingNull = true;

    if (flat!.currentMeterReading != null) {
      currentReadingString = flat.currentMeterReading!.toStringAsFixed(1);
      isCurrentReadingNull = false;
    }
    if (flat.previousMeterReading != null) {
      flat.previousMeterReading!.toStringAsFixed(1);
      isPreviousReadingNull = false;
    }

    return Column(
      children: [
        ListTile(
          leading: isCurrentReadingNull ? pendingIcon() : tickIcon(),
          title: const Text('বর্তমান  রিডিং'),
          subtitle: Text(currentReadingString),
        ),
        ListTile(
          // leading: Icon(Icons.info, color: Colors.red, size: 18),
          leading: isPreviousReadingNull ? pendingIcon() : tickIcon(),
          title: const Text('পূর্বের রিডিং'),
          subtitle: Text(previousReadingString),
        ),
      ],
    );
  }

  Icon tickIcon() =>
      const Icon(Icons.check_circle, color: Colors.green, size: 18);
  Icon pendingIcon() => const Icon(FontAwesomeIcons.circleQuestion,
      color: Colors.orange, size: 18);
}
