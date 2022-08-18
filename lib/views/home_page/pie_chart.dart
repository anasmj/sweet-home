// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:rent_home/models/dummy_renter.dart';
// import 'package:rent_home/models/renter.dart';
// import 'package:rent_home/screens/home_screen/components/payment_chart.dart';

// import '../user_history/user_history.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Column(
//       children: [
//         const PaymentChart(),
//         Expanded(
//           child: ListView.builder(
//             itemCount: renters.length,
//             itemBuilder: (context, index) {
//               DummyRenter renter = dummyRenters[index];
//               return Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: InkWell(
//                   onTap: () => Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => UserHistory(renter: renter),
//                       )),
//                   child: Card(
//                     color: Colors.white70,
//                     child: ListTile(
//                       leading: CircleAvatar(
//                         radius: 22.0,
//                         backgroundColor: renter.isPaid
//                             ? Colors.green
//                             : const Color.fromARGB(255, 214, 59, 59),
//                         child: renter.isPaid
//                             ? const Icon(Icons.check)
//                             : const Text(
//                                 'pending..',
//                                 style: TextStyle(
//                                     fontSize: 8.0,
//                                     color: Colors.black,
//                                     fontWeight: FontWeight.bold,
//                                     letterSpacing: 0.5),
//                               ),
//                       ),
//                       subtitle: Row(
//                         children: [
//                           Text(
//                             renter.name,
//                             style: const TextStyle(fontWeight: FontWeight.bold),
//                           ),
//                           renter.isNotified
//                               ? const Text(
//                                   ' (notified)',
//                                   style: TextStyle(fontSize: 12),
//                                 )
//                               : const Text(''),
//                         ],
//                       ),
//                       title: Row(
//                         children: [
//                           Text(renter.floor.toString()),
//                           Text(renter.flatNo),
//                         ],
//                       ),
//                       trailing: renter.isPaid
//                           ? const Icon(
//                               Icons.notifications,
//                               color: Colors.grey,
//                               size: 30,
//                             )
//                           : renter.isNotified
//                               ? const Icon(
//                                   Icons.notifications_active,
//                                   color: Colors.green,
//                                   size: 30,
//                                 )
//                               : const Icon(
//                                   Icons.notifications,
//                                   color: Color.fromARGB(255, 214, 59,
//                                       59), //Color.fromARGB(255, 80, 51, 9),
//                                   size: 30,
//                                 ),
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ],
//     ));
//   }
// }
