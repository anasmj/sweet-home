// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:sweet_home/mvvm/models/renter.dart';
// import 'package:sweet_home/prev/models/renter_transaction.dart';

// import '../../../../prev/utils/transaction_helper.dart';


// // ignore: must_be_immutable
// class TransactionListPageCopy extends StatelessWidget {
//   TransactionListPageCopy({required this.renter, super.key});

//   //TODO: make grouped by year
//   Renter renter;
//   @override
//   Widget build(BuildContext context) {
//     List<RenterTransaction> transactionList =
//         TransactionHelper(renter: renter).listOfAllTransactions();

//     return transactionList.isNotEmpty
//         ? ListView.builder(
//             itemCount: transactionList.length,
//             itemBuilder: (context, index) {
//               return Padding(
//                 padding:
//                     const EdgeInsets.symmetric(vertical: 16.0, horizontal: 10),
//                 child: TransactionCardC(
//                   transaction: transactionList[index],
//                 ),
//               );
//             },
//           )
//         : Center(
//             child: Text(
//               'দুঃক্ষিত!\nগ্রাহকের কোনও লেনদেন নেই',
//               textAlign: TextAlign.center,
//               style: Theme.of(context).textTheme.headline6,
//             ),
//           );
//   }
// }

// // ignore: must_be_immutable
// class TransactionCardC extends StatelessWidget {
//   TransactionCardC({
//     required this.transaction,
//     Key? key,
//   }) : super(key: key);
//   TransactionPrev transaction;
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       alignment: Alignment.topRight,
//       clipBehavior: Clip.none,
//       children: [
//         ListTile(
//           style: ListTileStyle.drawer,
//           tileColor: Theme.of(context).secondaryHeaderColor.withOpacity(0.5),

//           //PROFILE CIRCLE VATER
//           leading: CircleAvatar(
//             radius: 22,
//             child: transaction.transactionPrevBy != null
//                 ? Text(transaction.transactionPrevBy!.substring(0, 2))
//                 : const Text(''),
//           ),

//           //TRANSACTION AMOUNT
//           title: RichText(
//             text: TextSpan(
//               style: Theme.of(context).textTheme.headline6!.copyWith(
//                     color: Colors.green[900],
//                   ),
//               children: [
//                 const TextSpan(text: '+'),
//                 WidgetSpan(
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 4.0, vertical: 2),
//                     child: Image(
//                       height: 20,
//                       color: Colors.green[900],
//                       image: AssetImage(AppIcons.takaUrl),
//                     ),
//                   ),
//                 ),
//                 TextSpan(
//                   text: transaction.takenAmount.toStringAsFixed(1),
//                 ),
//               ],
//             ),
//           ),

//           //TRAILING: TRANSACTION BY
//           subtitle: transaction.transactionPrevBy != null
//               ? Text('${transaction.transactionPrevBy} এর মাধ্যমে')
//               : const Text(''),

//           //DUE
//           trailing: transaction.due == 0
//               ? checkMark()
//               : DueWidget(transaction: transaction),
//         ),

//         //TIME STAMP
//         Positioned(
//           top: -10,
//           right: 5,
//           child: Material(
//             borderRadius: BorderRadius.circular(4),
//             color: Theme.of(context).secondaryHeaderColor,
//             elevation: 2,
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 4),
//               child: Text(
//                   CustomFormatter().transactionTime(transaction.timeStamp)),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Padding checkMark() {
//     return Padding(
//       padding: const EdgeInsets.only(top: 12.0),
//       child: SvgPicture.asset(
//         AppIcons.checmarkUrl,
//         // color: Colors.green,
//         width: 36,
//       ),
//     );
//   }
// }

// class DueWidget extends StatelessWidget {
//   DueWidget({
//     Key? key,
//     required this.transaction,
//   }) : super(key: key);

//   final TransactionPrev transaction;
//   final Color? red = Colors.red[900];
//   final Color? green = Colors.green[900];
//   final String plus = '+';
//   final String minus = '-';
//   @override
//   Widget build(BuildContext context) {
//     return RichText(
//       text: TextSpan(
//         style: Theme.of(context).textTheme.subtitle1!.copyWith(
//               color: transaction.due != null
//                   ? transaction.due! > 0
//                       ? green
//                       : red
//                   : Colors.transparent,
//               fontWeight: FontWeight.bold,
//             ),
//         children: [
//           TextSpan(
//             text: transaction.due != null
//                 ? transaction.due! > 0
//                     ? plus
//                     : minus
//                 : '',
//           ),
//           WidgetSpan(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2),
//               child: Image(
//                 height: 16,
//                 color: transaction.due != null
//                     ? transaction.due! > 0
//                         ? green
//                         : red
//                     : Colors.transparent,
//                 image: AssetImage(AppIcons.takaUrl),
//               ),
//             ),
//           ),
//           TextSpan(
//             text: transaction.takenAmount.toStringAsFixed(1),
//           ),
//         ],
//       ),
//     );
//   }
// }
