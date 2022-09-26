// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:sweet_home/models/flat_model.dart';
// import 'package:sweet_home/providers/home_provider.dart';
// import '../../../../../providers/newrenter_step_provider.dart';
// import '../../../../app_widgets.dart';

// // ignore: must_be_immutable
// class FlatChoicieChips extends StatelessWidget {
//   FlatChoicieChips({super.key});

//   bool selected = false;

//   final Color _occupiedFlatChoiceChipColor = Colors.green.withOpacity(.20);
//   final Color _occupiedFlatSelectedColor = Colors.green.withOpacity(.40);
//   final Color _emptyFlatSelectedColor = Colors.red.withOpacity(.40);
//   final Color _occupiedFlatCircleAvatarColor = Colors.green.withOpacity(0.8);
//   final Color _emptyFaltCircleAvatarColor = Colors.red.withOpacity(0.8);
//   final Color _flatNameColor = Colors.white;
//   final Color _emptyFlatChoiceChipColor = Colors.red.withOpacity(.20);

//   @override
//   Widget build(BuildContext context) {
//     List<Flat> flatList = Provider.of<HomeProvider>(context).flats;
//     final provider = Provider.of<NewRenterStepProvider>(context);

//     return SingleChildScrollView(
//       child: Wrap(
//         spacing: 10,
//         runSpacing: 6,
//         children: List.generate(
//           flatList.length,
//           (flatNo) => ChoiceChip(
//             elevation: 4,
//             backgroundColor: flatList[flatNo].renter != null
//                 ? _occupiedFlatChoiceChipColor
//                 : _emptyFlatChoiceChipColor,
//             labelStyle: Theme.of(context).textTheme.subtitle1,
//             labelPadding:
//                 const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
//             label: flatList[flatNo].renter != null
//                 ? Text(flatList[flatNo].renter!.renterName)
//                 : const Text('খালি আছে'),
//             avatar: CircleAvatar(
//               backgroundColor: flatList[flatNo].renter != null
//                   ? _occupiedFlatCircleAvatarColor
//                   : _emptyFaltCircleAvatarColor,
//               radius: 14,
//               child: Text(
//                 flatList[flatNo].flatName,
//                 style: TextStyle(
//                   color: _flatNameColor,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             ),
//             selected: provider.selectedFlatNo == flatNo,
//             onSelected: ((bool selected) {
//               provider.setSelectedFlatNo(
//                   selected && flatList[flatNo].renter == null ? flatNo : null);

//               if (selected && flatList[flatNo].renter != null) {
//                 AppWidget.showToast("ফ্ল্যাটটি খালি নেই");
//               }
//             }),
//             selectedColor: flatList[flatNo].renter != null
//                 ? _occupiedFlatSelectedColor
//                 : _emptyFlatSelectedColor,
//           ),
//         ),
//       ),
//     );
//   }
// }
