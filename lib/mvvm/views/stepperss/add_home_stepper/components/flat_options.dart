// import 'package:flutter/material.dart';

// import '../../../../utils/user_flat.dart';

// class FlatSelector extends StatefulWidget {
//   const FlatSelector({super.key});

//   @override
//   State<FlatSelector> createState() => _FlatSelectorState();
// }

// //TODO: FIX THE CLASS
// class _FlatSelectorState extends State<FlatSelector> {
//   List<String>? flatList = [
//     '2A',
//     '2B',
//     '2c',
//   ];

//   List<bool> isSelected = [false, false, false];
//   List<bool> selectedList = [];
//   @override
//   Widget build(BuildContext context) {
//     var flats = UserFlats.getFlatList(flatRange: 4, floorRange: 6);
//     List<bool> selectedList = [];

//     for (int i = 0; i < flats.length; i++) {
//       selectedList.add(true);
//     }

//     return ToggleButtons(
//       onPressed: (int index) {
//         int count = 0;
//         isSelected.forEach((bool val) {
//           if (val) count++;
//         });

//         if (selectedList[index] && count < 24) return;

//         setState(() {
//           selectedList[index] = !selectedList[index];
//         });
//       },
//       isSelected: selectedList,
//       children: List.generate(flats.length, (index) {
//         return Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Text(flats[index]),
//         );
//       }),
//     );
//   }
// }
