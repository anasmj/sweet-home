import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sweet_home/mvvm/models/flat_model.dart';

import '../../app_widgets.dart';
import '../../resources/app_icons.dart';

//! intigrate with view model later
// ignore: must_be_immutable
class UserFlatList extends StatelessWidget {
  UserFlatList({required this.flatList, super.key});

  List<Flat> flatList;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 50,
          ),
          // upper part of container
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                noOfFlatText(context, flatList.length),
                const SizedBox(width: 18),
                Expanded(
                  child: AppWidget.appSearchBar(context: context),
                ),
                IconButton(
                  onPressed: () {
                    // FlatService().flatsCollectionRef(home!.homeId);
                  },
                  icon: const Icon(Icons.add),
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
          ),

          Expanded(
            child: GridView.builder(
              //childAspectRatio: (itemWidth / itemHeight),
              itemCount: flatList.length,
              itemBuilder: (context, index) {
                return makeFlatCard(context, flatList[index]);
              },
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 30,
                crossAxisSpacing: 10,
                childAspectRatio: 0.76,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget makeFlatCard(context, Flat flat) {
    TextTheme appTextTheme = Theme.of(context).textTheme;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(blurRadius: 2.0, offset: Offset(0, 0.1)),
            ],
            borderRadius: BorderRadius.circular(20),
            color: Theme.of(context).primaryColor,
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                flatRentAmount(flat, appTextTheme, context),
                SvgPicture.asset(
                  AppIcons.personAddUrl,
                  height: 40,
                  // width: 90,
                  color: Colors.black.withOpacity(0.6),
                ),

                //BOTTOM INFORMATION ABOUT FLAT
                const Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    'খালি আছে',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: -20,
          // left: ,
          child: CircleAvatar(
            backgroundColor: Theme.of(context).secondaryHeaderColor,
            radius: 20,
            child: Text(
              flat.flatName,
              style: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }

  Row flatRentAmount(Flat flat, TextTheme appTextTheme, context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Image(
          width: 20,
          image: AssetImage(AppIcons.takaUrl),
        ),
        const SizedBox(
          width: 6,
        ),
        SizedBox(
          width: 70,
          child: Text(
            flat.flatRentAmount.toString(),
            style: appTextTheme.headline6,
          ),
        ),

        //MENU THAT LEADS TO MODAL SHEET
        optionsButton(context: context),
      ],
    );
  }

  RichText noOfFlatText(BuildContext context, numOfFlat) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: 'ফ্ল্যাট সংখ্যাঃ ',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          TextSpan(
            text: numOfFlat.toString(),
            style: Theme.of(context).textTheme.headline6,
          ),
        ],
      ),
    );
  }

  PopupMenuButton<String> optionsButton({required BuildContext context}) {
    const String editOption = "তথ্য পরিবর্তন";
    const String deleteOption = "গ্রাহক মুছুন";
    const String flatDetailOption = "ফ্ল্যাটের বিস্তারিত";
    return PopupMenuButton<String>(
      tooltip: 'মেন্যু',
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      itemBuilder: (BuildContext context) => [
        const PopupMenuItem(
          value: editOption,
          child: Text(editOption),
        ),
        const PopupMenuItem(
          value: deleteOption,
          child: Text(deleteOption),
        ),
        const PopupMenuItem(
          value: flatDetailOption, //value can be int or any type
          child: Text(flatDetailOption),
        ),
      ],
      onSelected: (value) {
        switch (value) {
          case 'তথ্য পরিবর্তন':
            break; //_showModalSheet(),
          case 'গ্রাহক মুছুন':
            break; //_showModalSheet(),

          case 'ফ্ল্যাটের বিস্তারিত':
            break; //_showModalSheet(),
        }
      },
    );
  }
}
