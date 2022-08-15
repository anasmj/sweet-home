import 'package:flutter/material.dart';
import 'package:rent_home/models/renter.dart';
import 'package:rent_home/pages/app_icons.dart';
import 'package:rent_home/utils/custom_date_time_formatter.dart';
import 'package:rent_home/utils/transaction_helper.dart';

import '../../../models/transaction_model.dart';

class TransactionListPage extends StatelessWidget {
  TransactionListPage({required this.renter, super.key});

  //TODO: make grouped by year
  Renter renter;
  @override
  Widget build(BuildContext context) {
    List<Transaction> transactionList =
        TransactionHelper(renter: renter).ListOfAllTransactions();

    return Scaffold(
      appBar: AppBar(
        title: const Text('লেনদেনসমূহ'),
        centerTitle: true,
      ),
      body: transactionList.isNotEmpty
          ? ListView.builder(
              itemCount: transactionList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 10),
                  child: TransactionCard(
                    transaction: transactionList[index],
                  ),
                );
              },
            )
          : Center(
              child: Text(
                'দুঃক্ষিত!\nগ্রাহকের কোনও লেনদেন নেই',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
    );
  }
}

class TransactionCard extends StatelessWidget {
  TransactionCard({
    required this.transaction,
    Key? key,
  }) : super(key: key);
  Transaction transaction;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      clipBehavior: Clip.none,
      children: [
        ListTile(
          style: ListTileStyle.drawer,
          tileColor: Theme.of(context).secondaryHeaderColor.withOpacity(0.5),

          //PROFILE CIRCLE VATER
          leading: CircleAvatar(
            radius: 22,
            child: transaction.transactionBy != null
                ? Text(transaction.transactionBy!.substring(0, 2))
                : const Text(''),
          ),

          //TRANSACTION AMOUNT
          title: RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.headline6!.copyWith(
                    color: Colors.green[900],
                  ),
              children: [
                const TextSpan(text: '+'),
                WidgetSpan(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 4.0, vertical: 2),
                    child: Image(
                      height: 20,
                      color: Colors.green[900],
                      image: AssetImage(AppIcons().takaUrl),
                    ),
                  ),
                ),
                TextSpan(
                  text: transaction.takenAmount.toStringAsFixed(1),
                ),
              ],
            ),
          ),

          //TRAILING: TRANSACTION BY
          subtitle: transaction.transactionBy != null
              ? Text('${transaction.transactionBy} এর মাধ্যমে')
              : const Text(''),

          //DUE
          trailing: RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    color: Colors.red[900],
                    fontWeight: FontWeight.bold,
                  ),
              children: [
                const TextSpan(text: '-'),
                WidgetSpan(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 4.0, vertical: 2),
                    child: Image(
                      height: 16,
                      color: Colors.red[900],
                      image: AssetImage(AppIcons().takaUrl),
                    ),
                  ),
                ),
                TextSpan(
                  text: transaction.takenAmount.toStringAsFixed(1),
                ),
              ],
            ),
          ),
        ),

        //TIME STAMP
        Positioned(
          top: -10,
          right: 5,
          child: Material(
            borderRadius: BorderRadius.circular(4),
            color: Theme.of(context).secondaryHeaderColor,
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 4),
              child: Text(
                  CustomFormatter().transactionTime(transaction.timeStamp)),
            ),
          ),
        ),
      ],
    );
  }
}
