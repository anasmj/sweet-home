// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:sweet_home/utils/routes.dart';
// import 'package:sweet_home/providers/current_home.dart';
// import '../../../../models/home_model.dart';
// import '../../../../models/home_summary.dart';
// import '../../../../providers/theme_provider.dart';
// import '../../../../services/database_service/home_crud.dart';

// // ignore: must_be_immutable
// class HomeDropdown extends StatefulWidget {
//   HomeDropdown({super.key});

//   @override
//   State<HomeDropdown> createState() => _HomeDropdownState();
// }

// class _HomeDropdownState extends State<HomeDropdown> {
//   String? dropdownValue;

//   @override
//   Widget build(BuildContext context) {
//     final bool isDark = context.watch<ThemeProvider>().isDarkMode;
//     final providerWatch = context.watch<CurrentHomeProvider>();
//     CurrentHomeProvider providerRead = context.read<CurrentHomeProvider>();

//     final Color dropdownColorinDark = Colors.grey.shade700;
//     final Color dropdownColorinLight = Colors.blue.shade200;

//     return FutureBuilder<List<Home>?>(
//       future: HomeCrud().getAllHome(),
//       builder: (context, AsyncSnapshot<List<Home>?> snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const CircularProgressIndicator();
//         }
//         if (!snapshot.hasData) {}
//         final homes = snapshot.data;
//         if (homes!.isEmpty) return showAddHomeWidget(context);
//         if (providerWatch.getCurrentHome == null) {
//           providerRead.setCurrentHome(homes.first); 
//           providerRead.updateHomeId(homes.first.homeId!);
//         }
//         dropdownValue = providerWatch.currentHomeName;
//         return Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             IconButton(
//               onPressed: () {
//                 AppRoute.toCurrentHomeDetail(context);
//               },
//               icon: const Icon(Icons.home),
//               iconSize: 25,
//               color: context.watch<ThemeProvider>().isDarkMode
//                   ? Colors.white
//                   : Colors.black.withOpacity(0.5),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void refresh() => setState(() {});

//   InkWell showAddHomeWidget(BuildContext context) {
//     return InkWell(
//       onTap: () => AppRoute.newHomeStepper(context: context),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: const [
//           Text('বাড়ী যুক্ত'),
//           SizedBox(
//             width: 5,
//           ),
//           Icon(Icons.add),
//         ],
//       ),
//     );
//   }
// }
