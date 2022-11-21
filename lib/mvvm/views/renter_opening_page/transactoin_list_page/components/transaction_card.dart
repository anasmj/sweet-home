import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sweet_home/mvvm/models/transaction.dart';
import 'package:sweet_home/mvvm/utils/formatter.dart';
import 'package:sweet_home/mvvm/views/resources/app_icons.dart';

class TransactionCard extends StatelessWidget {
  TransactionCard({
    Key? key,
    required this.transaction,
  }) : super(key: key);
  final RenterTransaction transaction;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      clipBehavior: Clip.none,
      children: [
        ListTile(
          style: ListTileStyle.drawer,
          tileColor: Theme.of(context).secondaryHeaderColor,

          //PROFILE CIRCLE VATER
          leading: CircleAvatar(
            radius: 22,
            child: Text(transaction.paidBy.substring(0, 2)),
          ),

          //TRANSACTION AMOUNT
          title: Text(
            Formatter.toBn(value: transaction.amount),
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Colors.green[900], fontWeight: FontWeight.bold),
          ),
          subtitle: Text('${transaction.paidBy} এর মাধ্যমে'),
          trailing:
              Visibility(visible: transaction.isAdvance, child: advanceText),

          //DUE
          // trailing: checkMark()
          //DueWidget(transaction: transaction),
        ),

        //TIME STAMP
        TimeStampWidget(transaction: transaction),
      ],
    );
  }

  final Widget checkMark = Padding(
    padding: const EdgeInsets.only(top: 12.0),
    child: SvgPicture.asset(
      AppIcons.checmarkUrl,
      // color: Colors.green,
      width: 36,
    ),
  );

  final Widget advanceText = Container(
    decoration: BoxDecoration(
      color: Colors.cyan.shade300,
      borderRadius: BorderRadius.circular(4),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
    child: const Text('অগ্রীম'),
  );
}

class TimeStampWidget extends StatelessWidget {
  const TimeStampWidget({
    super.key,
    required this.transaction,
  });

  final RenterTransaction transaction;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: -10,
      right: 5,
      child: Material(
        borderRadius: BorderRadius.circular(4),
        color: Theme.of(context).secondaryHeaderColor,
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 4),
          child: Text(Formatter().appDateTime(transaction.time)),
        ),
      ),
    );
  }
}
