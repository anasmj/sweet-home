
//! will be deleted 
// import 'dart:core';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// import 'package:provider/provider.dart';
// import 'package:sweet_home/providers/home_provider.dart';

// import 'package:sweet_home/providers/flat_info_provider.dart';
// import 'package:sweet_home/utils/custom_date_time_formatter.dart';
// import '../../../../utils/routes.dart';

// import 'package:sweet_home/view/resources/app_icons.dart';

// //ELEMENT OF GRIDVIEW
// // ignore: must_be_immutable
// class FlatContainer extends StatelessWidget {
//   FlatContainer({
//     required this.flatNo,
//     super.key,
//   });
//   int flatNo;
//   final String _editOption = "তথ্য পরিবর্তন";
//   final String _deleteOption = "গ্রাহক মুছুন";
//   final String _flatDetailOption = "ফ্ল্যাটের বিস্তারিত";

//   String flatDetailsPageLocation = '/flat_details_page';

//   @override
//   Widget build(BuildContext context) {
//     late CurrentFlatInfoProvider currentFlatProvider =
//         Provider.of<CurrentFlatInfoProvider>(context, listen: false);
//     final flatList = Provider.of<HomeProvider>(context).flats;

//     TextTheme appTextTheme = Theme.of(context).textTheme;
//     return Stack(
//       clipBehavior: Clip.none,
//       children: [
//         InkWell(
//           onTap: flatList[flatNo].renter != null
//               ? () {
//                   ///gets updated
//                   currentFlatProvider.updateFlatInfo(
//                       currentFlat: flatList[flatNo]);
//                   AppRoute.flatDetail(context, flatList[flatNo]);
//                 }
//               : () =>
//                   AppRoute.newRenterStepper(context: context, flatNo: flatNo),
//           onLongPress: () {
//             //TODO: _showDeleteModalSheet
//           },
//           child: Material(
//             //shadowing
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(20),
//             ),
//             elevation: 3.0,
//             child: Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(20),
//                 color: Theme.of(context).primaryColor,
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.only(top: 8.0),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         Image(
//                           width: 20,
//                           image: AssetImage(AppIcons.takaUrl),
//                         ),
//                         const SizedBox(
//                           width: 6,
//                         ),
//                         SizedBox(
//                           width: 70,
//                           child: Text(
//                             flatList[flatNo].flatRentAmount.toString(),
//                             style: appTextTheme.headline6,
//                           ),
//                         ),

//                         //MENU THAT LEADS TO MODAL SHEET
//                         optionsButton(context: context),
//                       ],
//                     ),
//                     flatList[flatNo].renter == null
//                         ? SvgPicture.asset(
//                             AppIcons.personAddUrl,
//                             height: 40,
//                             // width: 90,
//                             color: Colors.black.withOpacity(0.6),
//                           )
//                         : const Text(''),
//                     //BOTTOM INFORMATION ABOUT FLAT
//                     flatList[flatNo].renter != null
//                         ? ListTile(
//                             title: Text(
//                               flatList[flatNo].renter!.name,
//                               maxLines: 1,
//                               overflow: TextOverflow.fade,
//                               softWrap: true,
//                             ),
//                             subtitle: Text(flatList[flatNo].renter != null
//                                 ? '${CustomFormatter().monthYear(flatList[flatNo].renter!.entryDate)} থেকে আছেন'
//                                 : ''),
//                           )
//                         : const Padding(
//                             padding: EdgeInsets.only(bottom: 10.0),
//                             child: Text(
//                               'খালি আছে',
//                               style: TextStyle(fontSize: 18),
//                             ),
//                           ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//         Positioned(
//           top: -20,
//           // left: ,
//           child: CircleAvatar(
//             backgroundColor: Theme.of(context).secondaryHeaderColor,
//             radius: 20,
//             child: Text(
//               flatList[flatNo].flatName,
//               style: Theme.of(context)
//                   .textTheme
//                   .bodyText2!
//                   .copyWith(fontWeight: FontWeight.bold),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   PopupMenuButton<String> optionsButton({required BuildContext context}) {
//     return PopupMenuButton<String>(
//       tooltip: 'মেন্যু',
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10),
//       ),
//       itemBuilder: (BuildContext context) => [
//         PopupMenuItem(
//           value: _editOption,
//           child: Text(_editOption),
//         ),
//         PopupMenuItem(
//           value: _deleteOption,
//           child: Text(_deleteOption),
//         ),
//         PopupMenuItem(
//           value: _flatDetailOption, //value can be int or any type
//           child: Text(_flatDetailOption),
//         ),
//       ],
//       onSelected: (value) {
//         switch (value) {
//           case 'তথ্য পরিবর্তন':
//             break; //_showModalSheet(),
//           case 'গ্রাহক মুছুন':
//             break; //_showModalSheet(),

//           case 'ফ্ল্যাটের বিস্তারিত':
//             break; //_showModalSheet(),
//         }
//       },
//     );
//   }
// }