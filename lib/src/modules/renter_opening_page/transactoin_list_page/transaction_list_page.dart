// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:provider/provider.dart';
// import 'package:sweet_home/mvvm/providers/current_home.dart';
// import 'package:sweet_home/mvvm/providers/selected_flat_provider.dart';

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
