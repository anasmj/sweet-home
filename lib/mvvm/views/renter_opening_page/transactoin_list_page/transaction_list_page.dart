// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:provider/provider.dart';
// import 'package:sweet_home/mvvm/providers/current_home.dart';
// import 'package:sweet_home/mvvm/providers/selected_flat_provider.dart';
// import 'package:sweet_home/mvvm/repositories/transaction_service.dart';
// import 'package:sweet_home/mvvm/utils/custom_date_time_formatter.dart';
// import 'package:sweet_home/mvvm/views/resources/app_icons.dart';


// import '../../../models/renter_transaction.dart';

// // ignore: must_be_immutable

// // ignore: must_be_immutable
// class TransactionList extends StatelessWidget {
//   const TransactionList({super.key});

//   @override
//   Widget build(BuildContext context) {
//     String homeId = context.read<CurrentHomeProvider>().currentHome!.homeId;
//     String flatId = context.read<SelectedFlatProvider>().selectedFlat!.flatName;
//     // return shwoNoTransaction();
//     List<RenterTransaction?> transactions;
//     return FutureBuilder<List<RenterTransaction?>>(
//         future: TransactionService()
//             .readAllTransactionB(homeId: homeId, flatId: flatId),
//         builder: (BuildContext context,
//             AsyncSnapshot<List<RenterTransaction?>> snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             if (snapshot.data != null) {
//               transactions = snapshot.data!;
//               if (transactions.length <= 1) {
//                 return shwoNoTransaction();
//               }
//               return showTransactionList(transactions);
//             }
//           }
//           return const Center(child: CircularProgressIndicator());
//         });
//   }

//   Center shwoNoTransaction() {
//     return const Center(
//       child: Text(
//         'কোনও লেনদেন পাওয়া যায়নি',
//         style: TextStyle(fontSize: 18),
//       ),
//     );
//   }
// }

// Widget showTransactionList(List<RenterTransaction?> transactions) {
//   late RenterTransaction renterTransaction;
//   return ListView.builder(
//     itemCount: transactions.length,
//     itemBuilder: (context, index) {
//       if (transactions[index] != null) {
//         renterTransaction = transactions[index]!;
//       }
//       return transactions[index] == null
//           ? const SizedBox()
//           : Padding(
//               padding: const EdgeInsets.only(top: 20.0),
//               child: TransactionCard(renterTransaction: renterTransaction),
//             );
//     },
//   );
// }

// class TransactionCard extends StatelessWidget {
//   TransactionCard({
//     required this.renterTransaction,
//     Key? key,
//   }) : super(key: key);
//   RenterTransaction renterTransaction;
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       alignment: Alignment.topRight,
//       clipBehavior: Clip.none,
//       children: [
//         ListTile(
//             style: ListTileStyle.drawer,
//             tileColor: Theme.of(context).secondaryHeaderColor.withOpacity(0.5),

//             //PROFILE CIRCLE VATER
//             leading: CircleAvatar(
//               radius: 22,
//               child: Text(renterTransaction.paidBy.substring(0, 2)),
//             ),

//             //TRANSACTION AMOUNT
//             title: RichText(
//               text: TextSpan(
//                 style: Theme.of(context).textTheme.headline6!.copyWith(
//                       color: Colors.green[900],
//                     ),
//                 children: [
//                   // const TextSpan(text: '+'),
//                   WidgetSpan(
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 4.0, vertical: 2),
//                       child: Image(
//                         height: 20,
//                         color: Colors.green[900],
//                         image: AssetImage(AppIcons.takaUrl),
//                       ),
//                     ),
//                   ),
//                   TextSpan(
//                     text: renterTransaction.amount.toStringAsFixed(1),
//                   ),
//                 ],
//               ),
//             ),

//             //TRAILING: TRANSACTION BY
//             subtitle: Text(' ${renterTransaction.paidBy} এর মাধ্যমে'),

//             //DUE
//             trailing: checkMark()
//             //DueWidget(transaction: transaction),
//             ),

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
//                   CustomFormatter().transactionTime(renterTransaction.time)),
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

//   final Transaction transaction;
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
