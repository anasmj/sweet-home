import 'package:flutter/material.dart';
import 'package:rent_home/models/others_model.dart';

class OthersTable extends StatelessWidget {
  OthersTable({this.othersList, super.key});
  List<OthersExpence>? othersList;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      child: Column(
        children: othersList != null
            ? othersList!.map((e) => buildRow(e)).toList()
            : [],
      ),
    );
  }

  Widget buildRow(OthersExpence obj) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(obj.purpose), Text(obj.amount.toString())],
      );
}
