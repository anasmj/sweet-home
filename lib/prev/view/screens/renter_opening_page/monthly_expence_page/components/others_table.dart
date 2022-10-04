import 'package:flutter/material.dart';
import 'package:sweet_home/prev/models/others_model.dart';

// ignore: must_be_immutable
class OthersTable extends StatelessWidget {
  OthersTable({this.othersList, super.key});
  List<OthersExpence>? othersList;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Column(
        children: othersList != null
            ? othersList!.map((e) => buildRow(e)).toList()
            : [],
      ),
    );
  }

  Widget buildRow(OthersExpence obj) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(obj.purpose),
          Text(
            obj.amount.toString(),
          ),
        ],
      );
}
