// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:provider/provider.dart';
// import 'package:sweet_home/mvvm/models/theme_provider.dart';
// import 'package:sweet_home/mvvm/views/renter_opening_page/renter_opening_page.dart';

// import '../../../../models/flat_model.dart';
// import '../../../../models/home_model.dart';
// import '../../../../providers/current_home.dart';
// import '../../../../providers/selected_flat_provider.dart';

// import '../../../../repositories/flat_services.dart';
// import '../../../../utils/custom_date_time_formatter.dart';
// import '../../../../../prev/utils/routes.dart';
// import '../../../../../prev/view_models/flat_list_viewmodel.dart';
// import '../../../../view_models/renter_opening_page_view_model.dart';
// import '../../../app_widgets.dart';
// import '../../../resources/app_icons.dart';
// import '../../../resources/image_urls.dart';
// import '../../../empty_pages/empty_flat_page.dart';
// import '../../../../../prev/view/screens/renter_opening_page/renter_opening_page.dart';
// import '../../../flat_info_pages/single_flat_info_page.dart';

// //!this is going to be rebuit
// //*ADOPTS VIEW MODEL
// // ignore: must_be_immutable
// class HomeFlatsPage extends StatelessWidget {
//   const HomeFlatsPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     Home? home = context.watch<CurrentHomeProvider>().currentHome;

//     return home == null ? const NoFlatPage() : futureBuilderMethod(home);
//   }

//   //if you want to use with view model

//   FutureBuilder<List<Flat>> futureBuilderMethod(Home home) {
//     return FutureBuilder<List<Flat>>(
//       future: FlatService().getAllFlats(homeId: home.homeId),
//       builder: (BuildContext context, AsyncSnapshot<List<Flat>> snapshot) {
//         if (snapshot.hasError) print('error in snapshot ');
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(
//             child: CircularProgressIndicator(),
//           );
//         }
//         if (snapshot.connectionState == ConnectionState.done) {
//           List<Flat>? flatList = snapshot.data;
//           if (flatList == null) {
//             return const Scaffold(
//               body: Center(
//                 child: Text(
//                   'flat list is null',
//                   style: TextStyle(color: Colors.black),
//                 ),
//               ),
//             );
//           }
//           if (flatList.isEmpty) {
//             return const Scaffold(
//               body: Center(child: Text('flat lisst is empty')),
//             );
//           }
//           return showFlats(context, flatList);
//         }
//         return const SizedBox();
//       },
//     );
//   }

//   Padding showFlats(BuildContext context, List<Flat> flatList) {
//     Home? home = context.watch<CurrentHomeProvider>().currentHome;

//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 12.0),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const SizedBox(
//             height: 50,
//           ),
//           // upper part of container
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 8.0),
//             child: Row(
//               children: [
//                 // noOfFlatText(context, flatList.length),
//                 const SizedBox(width: 18),
//                 Expanded(
//                   child: AppWidget.appSearchBar(context: context),
//                 ),
//                 const SizedBox(
//                   width: 10,
//                 ),
//               ],
//             ),
//           ),

//           Expanded(
//             child: RefreshIndicator(
//               onRefresh: () => FlatService().getAllFlats(homeId: home!.homeId),
//               child: GridView.builder(
//                 physics: const BouncingScrollPhysics(),
//                 //childAspectRatio: (itemWidth / itemHeight),
//                 itemCount: flatList.length,
//                 itemBuilder: (context, index) {
//                   Flat flat = flatList[index];

//                   return makeFlat(context, index, flat);
//                 },
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   mainAxisSpacing: 30,
//                   crossAxisSpacing: 10,
//                   childAspectRatio: 0.76,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget makeFlat(context, index, Flat flat) {
//     TextTheme appTextTheme = Theme.of(context).textTheme;
//     bool isDark = Provider.of<ThemeProvider>(context).isDarkMode;
//     RenterOpeningViewModel viewModel =
//         Provider.of<RenterOpeningViewModel>(context, listen: false);
//     String profileImageUrl = '';
//     // dynamic imageProvider;

//     return Stack(
//       clipBehavior: Clip.none,
//       children: [
//         InkWell(
//           onTap: () {
//             Provider.of<SelectedFlatProvider>(context, listen: false)
//                 .newSelectedFlat = flat;

//             flat.renter == null
//                 ? AppRoute.newRenterStepper(
//                     context: context,
//                   )
//                 : Navigator.of(context).push(
//                     MaterialPageRoute(
//                       builder: ((builder) => RenterOpeningPage()),
//                     ),
//                   );
//           },
//           onLongPress: () {
//             Provider.of<SelectedFlatProvider>(context, listen: false)
//                 .newSelectedFlat = flat;
//             AppWidget.getModalSheet(
//                 context: context,
//                 isDark: isDark,
//                 modalSheetContent: buildFlatOptionContent(context));
//           },
//           // flatOptionModalSheet(context: context, isDark: isDark),
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
//                 padding: const EdgeInsets.only(top: 16.0),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           flat.flatName,
//                           style: const TextStyle(
//                               fontSize: 18, fontWeight: FontWeight.bold),
//                         ),
//                         // const SizedBox(
//                         //   width: 45,
//                         // ),

//                         // rentAmountText(flat, appTextTheme, isDark),
//                       ],
//                     ),
//                     flat.renter == null
//                         ? personAddIcon(isDark)
//                         : flat.previousMeterReading == null
//                             ? AspectRatio(
//                                 aspectRatio: 2 / 0.8,
//                                 child: Center(
//                                   child: noMeterReadingIndicator(),
//                                 ),
//                               )
//                             // ignore: prefer_const_constructors
//                             : flat.flatName == '2A'
//                                 ? const CircleAvatar(
//                                     backgroundColor: Colors.green,
//                                     child: Icon(Icons.check))
//                                 : flat.flatName == '1A'
//                                     ? CircleAvatar(
//                                         backgroundColor:
//                                             Colors.orange.withOpacity(0.8),
//                                         child: const Icon(
//                                           Icons.more_horiz_rounded,
//                                           color: Colors.white,
//                                         ),
//                                       )
//                                     : const SizedBox(),

//                     // flat.previousMeterReading != null
//                     //     ? personAddIcon(isDark)
//                     //     : AspectRatio(
//                     //         aspectRatio: 2 / 0.8,
//                     //         child: Center(
//                     //           child: noMeterReadingIndicator(),
//                     //         ),
//                     //       ),
//                     //BOTTOM INFORMATION ABOUT FLAT
//                     flat.renter != null
//                         ? ListTile(
//                             title: Text(
//                               flat.renter!.renterName,
//                               maxLines: 1,
//                               overflow: TextOverflow.fade,
//                               softWrap: true,
//                             ),
//                             subtitle: Text(flat.renter != null
//                                 ? '${CustomFormatter().monthYear(flat.renter!.entryDate!)} থেকে আছেন'
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
//             backgroundColor:
//                 isDark ? Colors.grey.shade900 : Colors.blue.shade200,
//             radius: 24,
//             child: flat.renter != null
//                 ? CircleAvatar(
//                     backgroundColor: Theme.of(context).secondaryHeaderColor,
//                     radius: 20,
//                     backgroundImage: NetworkImage(
//                         flat.renter != null ? profileImageUrl : ''),
//                   )
//                 : CircleAvatar(
//                     backgroundColor: Theme.of(context).secondaryHeaderColor,
//                     radius: 20,
//                     child: Image.asset(
//                       AppIcons.defaultProfileUrl,
//                       height: 20,
//                       width: 22,
//                       fit: BoxFit.cover,
//                     )),
//           ),
//         ),
//       ],
//     );
//   }

//   SizedBox noMeterReadingIndicator() {
//     return SizedBox(
//       child: Stack(
//         clipBehavior: Clip.none,
//         alignment: Alignment.topRight,
//         children: [
//           Image.asset(
//             AppIcons.meterUrl,
//           ),
//           const Positioned(
//             top: -8,
//             right: 6,
//             child: CircleAvatar(
//               radius: 10,
//               backgroundColor: Colors.red,
//               child: Icon(
//                 Icons.question_mark_outlined,
//                 size: 16,
//                 color: Colors.white,
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }

//   SvgPicture personAddIcon(bool isDark) {
//     return SvgPicture.asset(
//       AppIcons.personAddUrl,
//       height: 40,
//       // width: 90,
//       color: isDark
//           ? Colors.white.withOpacity(0.6)
//           : Colors.black.withOpacity(0.6),
//     );
//   }

//   Column buildFlatOptionContent(context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         const SizedBox(height: 20),
//         ListTile(
//           onTap: () =>
//               Navigator.of(context).push(MaterialPageRoute(builder: (context) {
//             return const SingleFlatInfo();
//           })),
//           leading: const Icon(
//             Icons.info_outline,
//             color: Colors.pink,
//           ),
//           title: const Text('ফ্ল্যাটের বিস্তারিত'),
//         ),
//         const ListTile(
//           leading: Icon(
//             Icons.add,
//             color: Colors.blue,
//           ),
//           title: Text('গ্রাহক যুক্ত'),
//         ),
//         const ListTile(
//           leading: Icon(
//             Icons.remove_circle_outline_rounded,
//             color: Colors.orange,
//           ),
//           title: Text('গ্রাহক মুছুন'),
//         ),
//         const ListTile(
//           leading: Icon(
//             Icons.delete_outline_outlined,
//             color: Colors.red,
//           ),
//           title: Text('ফ্ল্যাট ডিলিট'),
//         ),
//       ],
//     );
//   }

//   // Row rentAmountText(Flat flat, TextTheme appTextTheme, bool isDark) {
//   //   return Row(
//   //     mainAxisSize: MainAxisSize.min,
//   //     children: [
//   //       Image(
//   //         width: 16,
//   //         image: AssetImage(
//   //           AppIcons.takaUrl,
//   //         ),
//   //         color: isDark ? Colors.white : Colors.black,
//   //       ),
//   //       const SizedBox(
//   //         width: 6,
//   //       ),
//   //       SizedBox(
//   //         width: 80,
//   //         child: Text(
//   //           flat.flatRentAmount.toString(),
//   //           overflow: TextOverflow.ellipsis,
//   //           softWrap: true,
//   //           maxLines: 1,
//   //           style: appTextTheme.headline6,
//   //         ),
//   //       ),
//   //     ],
//   //   );
//   // }

//   // RichText noOfFlatText(BuildContext context, numOfFlat) {
//   //   return RichText(
//   //     text: TextSpan(
//   //       children: [
//   //         TextSpan(
//   //           text: 'ফ্ল্যাট সংখ্যাঃ ',
//   //           style: Theme.of(context).textTheme.subtitle1,
//   //         ),
//   //         TextSpan(
//   //           text: numOfFlat.toString(),
//   //           style: Theme.of(context).textTheme.headline6,
//   //         ),
//   //       ],
//   //     ),
//   //   );
//   // }
// }