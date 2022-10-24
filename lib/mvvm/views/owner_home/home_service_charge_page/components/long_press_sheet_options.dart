import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// ignore: must_be_immutable
class LongPressSheetOptions extends StatelessWidget {
  LongPressSheetOptions({super.key, this.onRemoveRequest});
  VoidCallback? onRemoveRequest;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: ListTile(
        onTap: onRemoveRequest,
        leading: const Icon(
          FontAwesomeIcons.trashCan,
          color: Colors.red,
        ),
        title: const Text('সরিয়ে ফেলুন'),
      ),
    );
  }
}
