import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rent_home/models/database.dart';
import 'package:rent_home/models/others_model.dart';
import 'package:rent_home/providers/home_provider.dart';

class OthersTable extends StatelessWidget {
  OthersTable({super.key});
  // List<OthersExpence>? othersList = homes[0].otherExpences;
  @override
  Widget build(BuildContext context) {
    List<OthersExpence>? othersList =
        Provider.of<HomeProvider>(context).homeOtherExpences;
    return SizedBox(
      width: 180,
      child: Column(
        children: othersList != null
            ? othersList.map((e) => buildRow(e)).toList()
            : [],
      ),
    );
  }

  Widget buildRow(OthersExpence obj) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(obj.purpose), Text(obj.amount.toString())],
      );
}
