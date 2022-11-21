import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/mvvm/models/record.dart';
import 'package:sweet_home/mvvm/models/response.dart';
import 'package:sweet_home/mvvm/utils/formatter.dart';
import 'package:sweet_home/mvvm/view_models/flat_view_model.dart';
import 'package:sweet_home/mvvm/views/error_pages/error_page.dart';
import 'package:sweet_home/mvvm/views/records_page/records_page.dart';
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
                        Formatter().previousMonthYearBn(),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  RecordsPage(record: record)),
                        );
                        // setState(() {
                        //   _response = getRecord(context);
                        // });
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

  Row tableHeader(TextStyle colTitleTextStyle) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'বিবরণ',
          style: colTitleTextStyle,
        ),
        Text(
          'টাকার পরিমাণ',
          style: colTitleTextStyle,
        ),
      ],
    );
  }
}

class BottomBanner extends StatelessWidget {
  const BottomBanner({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 1,
            spreadRadius: 1,
            offset: const Offset(0, 2),
          )
        ],
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).secondaryHeaderColor,
      ),
      height: 50,
      width: 180,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'বুঝে পেয়েছি ৳ 2355 ',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Text(
            '23 Aug \'22',
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ],
      ),
    );
  }
}
