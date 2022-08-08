import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rent_home/pages/flat_details_page/flat_details.dart';
import '../../../models/flat_model.dart';
import '../../app_icons.dart';

//ELEMENT OF GRIDVIEW
class FlatContainer extends StatelessWidget {
  FlatContainer({
    required this.flat,
    super.key,
  });
  Flat flat;

  String FlatDetailsPageLocation = '/flat_details_page';

  @override
  Widget build(BuildContext context) {
    TextTheme appTextTheme = Theme.of(context).textTheme;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        InkWell(
          onTap: () {
            // Navigator.pushNamed(context, FlatDetailsPageLocation);
            // Navigator.push(context, PageTransition());
            Navigator.push(
              context,
              PageTransition(
                child: FlatDetails(),
                type: PageTransitionType.rightToLeft,
              ),
            );
          },
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
                            flat.rentAmount.toString(),
                            style: appTextTheme.headline6,
                          ),
                        ),

                        //MENU THAT LEADS TO MODAL SHEET
                        PopupMenuButton<int>(
                          tooltip: 'মেন্যু',
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          itemBuilder: (BuildContext context) => [
                            menuItem(
                              popUpValue: 1,
                              title: "তথ্য পরিবর্তন'",
                              popUpIcon: Icons.edit,
                            ),
                            menuItem(
                              popUpValue: 2,
                              title: "গ্রাহক মুছুন",
                              popUpIcon: Icons.delete,
                            ),
                            menuItem(
                              popUpValue: 3,
                              title: "নতুন গ্রাহক",
                              popUpIcon: Icons.person,
                            ),
                          ],
                          onSelected: (value) {
                            switch (value) {
                              case 1:
                                print('1');
                                break; //_showModalSheet(),
                              case 2:
                                print('2');
                                break; //_showModalSheet(),
                              case 3:
                                print('3');
                                break; //_showModalSheet(),

                            }
                          },
                        )
                      ],
                    ),

                    //BOTTOM INFORMATION ABOUT FLAT
                    flatStatus()
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

  PopupMenuItem<int> menuItem(
      {required int popUpValue, required String title, IconData? popUpIcon}) {
    return PopupMenuItem(
      value: popUpValue,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(popUpIcon),
          Text(title),
        ],
      ),
    );
  }

  ListTile flatStatus() {
    return ListTile(
      //leading: CircleAvatar(),
      title: Text(
        flat.renter != null ? flat.renter!.name : 'খালি আছে',
        maxLines: 1,
        overflow: TextOverflow.fade,
        softWrap: true,
      ),
      subtitle: Text("2 Jun, 22 থেকে"),
    );
  }
}
