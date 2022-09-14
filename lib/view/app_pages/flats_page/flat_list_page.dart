// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:sweet_home/view/app_pages/flats_page/components/flat_container.dart';
// import 'package:sweet_home/view/app_pages/flats_page/empty_flat_page.dart';
// import 'package:sweet_home/view/app_widgets.dart';
// import 'package:sweet_home/providers/home_provider.dart';
// import '../../../models/flat_model.dart';
// import '../../resources/app_icons.dart';
// import 'components/customize_button.dart';

// String flatDetailsPageLocation = '/flat_details_page';

// class FlatListPage extends StatelessWidget {
//   FlatListPage({super.key});
//   bool isInitialState = false;
//   @override
//   Widget build(BuildContext context) {
//     isInitialState = false;
//     final home = Provider.of<HomeProvider>(context);
//     TextTheme appTextTheme = Theme.of(context).textTheme;
//     return isInitialState
//         ? const NoFlatPage()
//         : Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 12.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const SizedBox(
//                   height: 40,
//                 ),
//                 //upper part of container
//                 Row(
//                   children: [
//                     Expanded(
//                       child: AppWidget.appSearchBar(context: context),
//                     ),
//                     const SizedBox(
//                       width: 10,
//                     ),

//                     //button
//                     const CustomizeButton()
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 40,
//                 ),
//                 noOfFlatText(context, home),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 Expanded(
//                   child: home.flats.isNotEmpty
//                       ? GridView.builder(
//                           //childAspectRatio: (itemWidth / itemHeight),
//                           itemCount: home.flats.length,
//                           itemBuilder: (context, index) {
//                             return FlatContainer(flatNo: index);
//                           },
//                           gridDelegate:
//                               const SliverGridDelegateWithFixedCrossAxisCount(
//                             crossAxisCount: 2,
//                             mainAxisSpacing: 40,
//                             crossAxisSpacing: 10,
//                             childAspectRatio: 0.76,
//                           ),
//                         )
//                       : Center(
//                           child: Text(
//                             'কোনও ফ্ল্যাট যুক্ত নেই',
//                             style: appTextTheme.subtitle1,
//                           ), //TODO: SHOW AN ADD BUTTON INSTEAD
//                         ),
//                 ),
//               ],
//             ),
//           );
//   }

//   RichText noOfFlatText(BuildContext context, HomeProvider home) {
//     return RichText(
//       text: TextSpan(
//         children: [
//           TextSpan(
//             text: 'ফ্ল্যাট সংখ্যাঃ ',
//             style: Theme.of(context).textTheme.subtitle1,
//           ),
//           TextSpan(
//             text: home.flats.length.toString(),
//             style: Theme.of(context).textTheme.headline6,
//           ),
//         ],
//       ),
//     );
//   }
// }
