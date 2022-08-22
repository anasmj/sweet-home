import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/providers/home_provider.dart';
import 'package:sweet_home/views/flat_details_page/flat_details.dart';
import 'package:sweet_home/providers/flat_info_provider.dart';
import 'package:sweet_home/controllers/custom_date_time_formatter.dart';
import '../../../models/flat_model.dart';
import '../../../providers/newrenter_step_provider.dart';
import '../../app_icons.dart';
import '../../steppers/new_renter_stepper/add_renter_stepper.dart';

//ELEMENT OF GRIDVIEW
class FlatContainer extends StatelessWidget {
  FlatContainer({
    required this.flatNo,
    super.key,
  });
  int flatNo;
  final String _editOption = "তথ্য পরিবর্তন";
  final String _deleteOption = "গ্রাহক মুছুন";
  final String _newOption = "নতুন গ্রাহক";
  final String _flatDetailOption = "ফ্ল্যাটের বিস্তারিত";

  String flatDetailsPageLocation = '/flat_details_page';
  void gotoFlatDetail(BuildContext context, Flat flat) => Navigator.push(
        context,
        PageTransition(
          child: FlatDetails(
            renter: flat.renter!,
          ),
          type: PageTransitionType.rightToLeft,
        ),
      );
  void gotoNewRenterStepper(
      {required BuildContext context, required int flatNo}) {
    Navigator.push(
      context,
      PageTransition(
        child: AddRenterStepper(),
        type: PageTransitionType.fade,
      ),
    );
    context.read<NewRenterStepProvider>().setSelectedFlatNo(flatNo);
  }

  @override
  Widget build(BuildContext context) {
    late CurrentFlatInfoProvider currentFlatProvider =
        Provider.of<CurrentFlatInfoProvider>(context, listen: false);
    final flatList = Provider.of<HomeProvider>(context).flats;

    TextTheme appTextTheme = Theme.of(context).textTheme;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        InkWell(
          onTap: flatList[flatNo].renter != null
              ? () {
                  ///gets updated
                  currentFlatProvider.updateFlatInfo(
                      currentFlat: flatList[flatNo]);
                  gotoFlatDetail(context, flatList[flatNo]);
                }
              : () => gotoNewRenterStepper(context: context, flatNo: flatNo),
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
                          image: AssetImage(AppIcons.takaUrl),
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        SizedBox(
                          width: 70,
                          child: Text(
                            flatList[flatNo].flatRentAmount.toString(),
                            style: appTextTheme.headline6,
                          ),
                        ),

                        //MENU THAT LEADS TO MODAL SHEET
                        optionsButton(context: context),
                      ],
                    ),
                    flatList[flatNo].renter == null
                        ? SvgPicture.asset(
                            AppIcons.personAddUrl,
                            height: 40,
                            // width: 90,
                            color: Colors.black.withOpacity(0.6),
                          )
                        : const Text(''),
                    //BOTTOM INFORMATION ABOUT FLAT
                    flatList[flatNo].renter != null
                        ? ListTile(
                            title: Text(
                              flatList[flatNo].renter!.name,
                              maxLines: 1,
                              overflow: TextOverflow.fade,
                              softWrap: true,
                            ),
                            subtitle: Text(flatList[flatNo].renter != null
                                ? '${CustomFormatter().monthYear(flatList[flatNo].renter!.entryDate)} থেকে আছেন'
                                : ''),
                          )
                        : const Padding(
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
          ),
        ),
        Positioned(
          top: -20,
          // left: ,
          child: CircleAvatar(
            radius: 20,
            child: Text(
              flatList[flatNo].flatName,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ],
    );
  }

  PopupMenuButton<String> optionsButton({required BuildContext context}) {
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
            Navigator.push(
              context,
              PageTransition(
                child: AddRenterStepper(),
                type: PageTransitionType.fade,
              ),
            );

            break; //_showModalSheet(),
          case 'ফ্ল্যাটের বিস্তারিত':
            break; //_showModalSheet(),
        }
      },
    );
  }
}
