import 'package:flutter/material.dart';
import 'package:sweet_home/mvvm/models/utility.dart';
import 'package:sweet_home/mvvm/utils/formatter.dart';

// ignore: must_be_immutable
class UtilityTable extends StatelessWidget {
  UtilityTable({
    super.key,
    required this.utilityList,
  });
  List<Utility> utilityList;

  @override
  Widget build(BuildContext context) {
    if (utilityList.isEmpty) return const SizedBox.shrink();
    return SizedBox(
      width: 200,
      child: Column(
        children: utilityList.map((e) => buildRow(e)).toList(),
      ),
    );
  }

  Widget buildRow(Utility obj) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(obj.purpose),
          Text(Formatter.toBn(value: obj.amount)),
        ],
      );
}
