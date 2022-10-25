// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:provider/provider.dart';
// import 'package:sweet_home/mvvm/utils/enums.dart';
// import 'package:sweet_home/mvvm/view_models/flat_list_view_model.dart';
// import 'package:sweet_home/mvvm/views/empty_pages/empty_flat_page.dart';
// import '../../models/flat_model.dart';
// import '../app_widgets.dart';
// import '../waiting_pages/searching_indicator.dart';
// import 'components/flat_container.dart';

//!VIEW MODEL APPROACH IS REPLACED BY STEAM BUILDER 
// // ignore: must_be_immutable
// class AllFlat extends StatelessWidget {
//   AllFlat({super.key});

//   late FlatListViewModel flatListViewModel;
//   //STREAM APPROACH

//   @override
//   Widget build(BuildContext context) {
//     flatListViewModel = Provider.of<FlatListViewModel>(context);
//     List<Flat> flatList = flatListViewModel.flatList;
//     if (flatListViewModel.status == Status.loading) {
//       return const SearchingIndicator();
//     }
//     // if (flatListViewModel.isLoading) return const SearchingIndicator();
//     if (flatListViewModel.flatList.isEmpty) return const NoFlatPage();
//     if (flatListViewModel.hasError) return const SizedBox.shrink();
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 12.0),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const SizedBox(height: 50),
//           Row(
//             children: [
//               Expanded(child: AppWidget.appSearchBar(context: context)),
//               IconButton(
//                   onPressed: () {
//                     Provider.of<FlatListViewModel>(context, listen: false)
//                         .configureFltas();
//                   },
//                   icon: const Icon(FontAwesomeIcons.rotate)),
//             ],
//           ),
//           const SizedBox(height: 10),
//           Expanded(
//             child: GridView.builder(
//               physics: const BouncingScrollPhysics(),
//               //childAspectRatio: (itemWidth / itemHeight),
//               itemCount: flatList.length,
//               itemBuilder: (context, index) {
//                 Flat flat = flatList[index];
//                 return FlatContainer(flat: flat);
//               },
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 mainAxisSpacing: 60,
//                 crossAxisSpacing: 12,
//                 childAspectRatio: 0.76,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
