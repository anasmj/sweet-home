import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/mvvm/models/record.dart';
import 'package:sweet_home/mvvm/models/response.dart';
import 'package:sweet_home/mvvm/utils/formatter.dart';
import 'package:sweet_home/mvvm/view_models/flat_view_model.dart';
import 'package:sweet_home/mvvm/views/error_pages/error_page.dart';
import 'expence_table/confirm_expence_table.dart';
import 'expence_table/record_expence_table.dart';

class MonthlyExpence extends StatefulWidget {
  const MonthlyExpence({super.key});

  @override
  State<MonthlyExpence> createState() => _MonthlyExpenceNewState();
}

class _MonthlyExpenceNewState extends State<MonthlyExpence> {
  Future<Response>? _response;
  @override
  void initState() {
    super.initState();
    _response = getRecord(context);
  }

  Future<Response> getRecord(BuildContext context) async {
    return await context.read<FlatViewModel>().getLastMonthRecord();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle colTitleText = Theme.of(context).textTheme.titleLarge!;

    return FutureBuilder<Response>(
      future: _response,
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasError) return const ErrorPage();
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        } else {
          Response res = snapshot.data!;
          if (res.code != 200) return const ErrorPage();
          Record? record = res.content;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        Formatter().previousMonthYear(),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _response = getRecord(context);
                        });
                      },
                      child: Row(
                        children: const [
                          Text('পূর্বের হিসাবসমূহ'),
                          SizedBox(
                            width: 8,
                          ),
                          Icon(Icons.arrow_forward_ios_rounded, size: 16)
                        ],
                      ),
                    )
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 0, 4),
                  child: tableHeader(colTitleText),
                ),

                //DATA TABLE
                Expanded(
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      record != null
                          ? RecordExpenceTable(record: record)
                          : ConfirmExpenceTable(),
                      // const Padding(
                      //   padding: EdgeInsets.only(bottom: 20),
                      //   child: BottomBanner(),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  Row tableHeader(TextStyle colTitleText) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'বিবরণ',
          style: colTitleText,
        ),
        Text(
          'টাকার পরিমাণ',
          style: colTitleText,
        ),
      ],
    );
  }
}
