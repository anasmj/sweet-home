import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ExpenctOptionsSheetContent extends StatelessWidget {
  const ExpenctOptionsSheetContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          ListTile(
            leading: Icon(
              Icons.edit,
              color: Colors.blue,
            ),
            title: Text('তথ্য পরিবর্তন'),
          ),
          ListTile(
            leading: Icon(
              FontAwesomeIcons.trashCan,
              color: Colors.red,
            ),
            title: Text('মুছে ফেলুন'),
          ),
        ],
      ),
    );
  }
}
