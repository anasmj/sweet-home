import 'package:flutter/material.dart';
import 'package:rent_home/models/others_model.dart';

class OthersTable extends StatelessWidget {
  const OthersTable({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      child: Column(
        children: othersList.map((e) => buildRow(e)).toList(),
      ),
    );
  }

  Widget buildRow(Others obj) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(obj.purpose), Text(obj.amount.toString())],
      );
}
