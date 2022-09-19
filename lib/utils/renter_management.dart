// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:sweet_home/providers/home_provider.dart';

// import '../models/flat_model.dart';
// import '../models/renter.dart';
// import '../providers/newrenter_step_provider.dart';

// class RenterManagement {
//   static void addRenterToFlat({required BuildContext context}) {
//     int flatNo = context.read<NewRenterStepProvider>().selectedFlatNo;
//     List<Flat> flatList = context.read<HomeProvider>().flats;

//     //making renter object
//     final newRenterInfo = context.read<NewRenterStepProvider>();
//     String renterName = newRenterInfo.getRenterName;
//     DateTime dateOfEntry = DateTime.parse('2022-03-12');

//     int noOfPerson = newRenterInfo.memberNo;
//     Flat flat = flatList[flatNo];
//     // print(flat.flatName);
//     // print(renterName);
//     // print(dateOfEntry.toIso8601String());
//     flat.renter = Renter(
//       renterName: renterName,
//       entryDate: dateOfEntry,
//       records: [],
//       numOfPerson: noOfPerson,
//     );
//     // if (flatList[flatNo].renter != null) {
//     //   print(flatList[flatNo].renter!.name);
//     // }
//   }
// }
