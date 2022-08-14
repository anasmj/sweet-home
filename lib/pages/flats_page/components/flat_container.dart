import 'dart:core';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rent_home/pages/flat_details_page/flat_details.dart';
import 'package:rent_home/utils/custom_date_time_formatter.dart';
import '../../../models/flat_model.dart';
import '../../app_icons.dart';

//ELEMENT OF GRIDVIEW
class FlatContainer extends StatelessWidget {
  FlatContainer({
    required this.flat,
    super.key,
  });
  Flat flat;
  final String _editOption = "তথ্য পরিবর্তন";
  final String _deleteOption = "গ্রাহক মুছুন";
  final String _newOption = "নতুন গ্রাহক";
  final String _flatDetailOption = "ফ্ল্যাটের বিস্তারিত";

  String flatDetailsPageLocation = '/flat_details_page';

  @override
  Widget build(BuildContext context) {
    TextTheme appTextTheme = Theme.of(context).textTheme;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        //! onTap wont work if renter is not available
        InkWell(
          onTap: flat.renter != null
              ? () {
                  Navigator.push(
                    context,
                    PageTransition(
                      child: FlatDetails(
                        renter: flat.renter!,
                      ),
                      type: PageTransitionType.rightToLeft,
                    ),
                  );
                }
              : null,
          onLongPress: () {
            //TODO: _showDeleteModalSheet
          },
          child: Material(
            //shadowing
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 3.0,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.blue.withOpacity(0.4),
                // boxShadow: [BoxShadow(blurRadius: 2.0, spreadRadius: 1.0)]
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Image(
                          width: 20,
                          image: AssetImage(AppIcons().takaUrl),
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        SizedBox(
                          width: 70,
                          child: Text(
                            //TODO: make visible local value instead
                            //home.globalRentAmount.toString(),
                            flat.flatRentAmount.toString(),
                            //flatRentAmount.toString(),
                            style: appTextTheme.headline6,
                          ),
                        ),

                        //MENU THAT LEADS TO MODAL SHEET
                        optionsButton()
                      ],
                    ),

                    //BOTTOM INFORMATION ABOUT FLAT
                    ListTile(
                      //leading: CircleAvatar(),
                      title: Text(
                        flat.renter != null ? flat.renter!.name : 'খালি আছে',
                        maxLines: 1,
                        overflow: TextOverflow.fade,
                        softWrap: true,
                      ),
                      subtitle: Text(flat.renter != null
                          ? '${CustomFormatter().monthYear(flat.renter!.entryDate)} থেকে আছেন'
                          : ''),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: -20,
          // left: ,
          child: CircleAvatar(
            radius: 20,
            child: Text(
              flat.flatName,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ],
    );
  }

  PopupMenuButton<String> optionsButton() {
    return PopupMenuButton<String>(
      tooltip: 'মেন্যু',
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      itemBuilder: (BuildContext context) => [
        PopupMenuItem(
          value: _editOption,
          child: Text(_editOption),
        ),
        PopupMenuItem(
          value: _deleteOption,
          child: Text(_deleteOption),
        ),
        PopupMenuItem(
          value: _newOption, //value can be int or any type
          child: Text(_newOption),
        ),
        PopupMenuItem(
          value: _flatDetailOption, //value can be int or any type
          child: Text(_flatDetailOption),
        ),
      ],
      onSelected: (value) {
        switch (value) {
          case 'তথ্য পরিবর্তন':
            break; //_showModalSheet(),
          case 'গ্রাহক মুছুন':
            break; //_showModalSheet(),
          case 'নতুন গ্রাহক':
            break; //_showModalSheet(),
          case 'ফ্ল্যাটের বিস্তারিত':
            break; //_showModalSheet(),
        }
      },
    );
  }
}
