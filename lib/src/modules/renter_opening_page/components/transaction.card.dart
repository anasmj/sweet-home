import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sweet_home/src/constants/constants.dart';
import 'package:sweet_home/src/extensions/extensions.dart';
import 'package:sweet_home/src/model/transaction.dart';

class TransactionCard extends StatelessWidget {
  const TransactionCard({
    required this.renterTransaction,
    Key? key,
  }) : super(key: key);
  final RenterTransaction renterTransaction;
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
              child: Text(renterTransaction.paidBy.substring(0, 2)),
            ),

            //TRANSACTION AMOUNT
            title: RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.headline6!.copyWith(
                      color: Colors.green[900],
                    ),
                children: [
                  // const TextSpan(text: '+'),
                  WidgetSpan(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4.0, vertical: 2),
                      child: Image(
                        height: 20,
                        color: Colors.green[900],
                        image: AssetImage(AssetPath.takaUrl),
                      ),
                    ),
                  ),
                  TextSpan(
                    text: renterTransaction.amount.toStringAsFixed(1),
                  ),
                ],
              ),
            ),

            //TRAILING: TRANSACTION BY
            subtitle: Text(' ${renterTransaction.paidBy} এর মাধ্যমে'),

            //DUE
            trailing: checkMark()
            //DueWidget(transaction: transaction),
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
                renterTransaction.time.formatted(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Padding checkMark() {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: SvgPicture.asset(
        AssetPath.checmarkUrl,
        // color: Colors.green,
        width: 36,
      ),
    );
  }
}
