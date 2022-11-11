import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/mvvm/models/response.dart';
import 'package:sweet_home/mvvm/view_models/flat_view_model.dart';
import 'package:sweet_home/mvvm/views/app_widgets.dart';

import 'expence_table/confirm_expence_table.dart';
import 'expence_table/record_expence_table.dart';
import 'monthly_expence.dart';

class MonthlyExpenceNew extends StatefulWidget {
  const MonthlyExpenceNew({super.key});

  @override
  State<MonthlyExpenceNew> createState() => _MonthlyExpenceNewState();
}

class _MonthlyExpenceNewState extends State<MonthlyExpenceNew> {
  Future<Response>? _response;
  @override
  void initState() {
    super.initState();
    _response = getRecord(context);
  }

  Future<Response> getRecord(BuildContext context) async {
    return context.read<FlatViewModel>().getLastMonthRecord();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Response>(
        future: _response,
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            Response res = snapshot.data!;
            if (res.code == 200) {
              //previous month found
              return MonthlyExpence(
                table: RecordExpenceTable(record: res.content),
              );
            } else if (res.code == 201) {
              //need to create previous month
              return ConfirmExpenceTable();
            } else {
              //error fetching data from firebase
              AppWidget.showSnackBarWithMsg(msg: 'Error: ${res.body}');
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
          return const SizedBox.shrink();
        });
  }
}
