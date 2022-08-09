// import 'package:flutter/material.dart';

// import '../../models/dummy_renter.dart';
// import 'components/annual_history_template.dart';
// import 'components/custom_app_bar.dart';

// class UserHistory extends StatefulWidget {
//   const UserHistory({super.key, required this.renter});
//   //final DummyRenter renter;
//   @override
//   State<UserHistory> createState() => _UserHistoryyState();
// }

// class _UserHistoryyState extends State<UserHistory> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: CustomScrollView(
//       slivers: [
//         const SliverAppBar(

//             //title: Text(widget.renter.name),
//             expandedHeight: 250,
//             //centerTitle: true,
//             flexibleSpace: FlexibleSpaceBar(
//               background: SizedBox(
//                 width: 80,
//                 child: CustomAppBar(),
//                 // child: getAnnualRecordCard(
//                 //   listOfMonthDetails: widget.renter.records![0].months,
//                 //   yearNo: widget.renter.records![0].yearNo,
//                 // ),
//               ),
//             )),
//         SliverToBoxAdapter(
//           child: ListView.builder(
//             primary: false,
//             shrinkWrap: true,
//             itemCount: widget.renter.records!.length,
//             itemBuilder: (context, index) {
//               // return Padding(
//               //   padding: const EdgeInsets.symmetric(vertical: 50.0),
//               //   child: Text('content'),
//               // );
//               return getAnnualRecordCard(
//                   listOfMonthDetails: widget.renter.records![index].months,
//                   yearNo: widget.renter.records![index].yearNo);
//             },
//           ),
//         )
//       ],
//     ));
//   }
// }
