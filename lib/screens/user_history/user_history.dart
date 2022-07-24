import 'package:flutter/material.dart';

import '../../models/dummy_renter.dart';
import 'components/annual_history_template.dart';

class UserHistory extends StatefulWidget {
  const UserHistory({super.key, required this.renter});
  final DummyRenter renter;
  @override
  State<UserHistory> createState() => _UserHistoryyState();
}

class _UserHistoryyState extends State<UserHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          title: Text(widget.renter.name),
          expandedHeight: 200,
          centerTitle: true,
        ),
        SliverToBoxAdapter(
          child: ListView.builder(
            primary: false,
            shrinkWrap: true,
            itemCount: widget.renter.records!.length,
            itemBuilder: (context, index) {
              return getAnnualRecordCard(
                  listOfMonthDetails: widget.renter.records![index].months,
                  yearNo: widget.renter.records![index].yearNo);
            },
          ),
        )
      ],
    ));
  }
}
