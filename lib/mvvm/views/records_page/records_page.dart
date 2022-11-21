import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/mvvm/models/record.dart';
import 'package:sweet_home/mvvm/view_models/record_view_model.dart';
import 'package:sweet_home/mvvm/views/error_pages/error_page.dart';
import 'package:sweet_home/mvvm/views/renter_opening_page/monthly_expence_page/expence_table/record_expence_table.dart';

class RecordsPage extends StatefulWidget {
  const RecordsPage({super.key, this.record});
  final Record? record;

  @override
  State<RecordsPage> createState() => _RecordsPageState();
}

class _RecordsPageState extends State<RecordsPage> {
  Future<List<Record>>? _records;

  @override
  void initState() {
    super.initState();
    _records = getRecords();
  }

  Future<List<Record>> getRecords() async =>
      await context.read<RecordViewModel>().getRecords();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('পূর্বের হিসাবসমূহ'),
      ),
      // body: ListView.builder(
      //   itemCount: 20,
      //   itemBuilder: (context, index) => RecordTable(record: record),
      // ),
      body: FutureBuilder<List<Record>>(
          future: _records,
          builder: (BuildContext context, snapshot) {
            if (snapshot.hasError) return const ErrorPage();
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              var recordList = snapshot.data;
              return ListView.builder(
                  itemCount: recordList!.toList().length,
                  itemBuilder: (context, index) =>
                      RecordTable(record: recordList[index]));
            }
          }),
    );
  }
}

class RecordTable extends StatelessWidget {
  const RecordTable({
    super.key,
    required this.record,
  });

  final Record record;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(record.recordId),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 0, 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'বিবরণ',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      'টাকার পরিমাণ',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
              ),

              //DATA TABLE
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  RecordExpenceTable(record: record)

                  // const Padding(
                  //   padding: EdgeInsets.only(bottom: 20),
                  //   child: BottomBanner(),
                  // ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
