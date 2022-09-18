import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/providers/current_home.dart';
import 'package:sweet_home/providers/theme_provider.dart';
import 'package:sweet_home/services/flat_services.dart';
import 'package:sweet_home/view/app_pages/flat_details_page/flat_details.dart';
import '../../../models/flat_model.dart';
import '../../../models/home_model.dart';
import '../../../providers/flat_info_provider.dart';
import '../../../utils/custom_date_time_formatter.dart';
import '../../../utils/routes.dart';
import '../../../view_models/flat_list_viewmodel.dart';
import '../../app_widgets.dart';
import '../../resources/app_icons.dart';
import '../empty_pages/empty_flat_page.dart';
import '../flat_details_page/flat_details_copy.dart';
import 'components/flat_menu_popup.dart';

//*ADOPTS VIEW MODEL
// ignore: must_be_immutable
class HomeFlatsPage extends StatelessWidget {
  HomeFlatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    Home? home = context.watch<CurrentHomeProvider>().currentHome;

    return home == null ? const EmptyFlatPage() : futureBuilderMethod(home);
  }

  //if you want to use with view model
  _ui(BuildContext context, FlatListViweModel vm) {
    if (!vm.loading) {
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
                  noOfFlatText(context, vm.flatListModel.length),
                  const SizedBox(width: 18),
                  Expanded(
                    child: AppWidget.appSearchBar(context: context),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),

            Expanded(
              child: GridView.builder(
                physics: const BouncingScrollPhysics(),
                //childAspectRatio: (itemWidth / itemHeight),
                itemCount: vm.flatListModel.length,
                itemBuilder: (context, index) {
                  Flat flat = vm.flatListModel[index];

                  return makeFlat(context, index, flat);
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
  }

  FutureBuilder<List<Flat>> futureBuilderMethod(Home home) {
    return FutureBuilder<List<Flat>>(
      future: FlatService().getAllFlats(homeId: home.homeId),
      builder: (BuildContext context, AsyncSnapshot<List<Flat>> snapshot) {
        if (snapshot.hasError) print('error in snapshot ');
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          List<Flat>? flatList = snapshot.data;
          if (flatList == null) {
            return const Scaffold(
              body: Center(
                child: Text(
                  'flat list is null',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            );
          }
          if (flatList.isEmpty) {
            return const Scaffold(
              body: Center(child: Text('flat list is empty')),
            );
          }
          return showFlats(context, flatList);
        }
        return const SizedBox();
      },
    );
  }

  Padding showFlats(BuildContext context, List<Flat> flatList) {
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
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
          ),

          Expanded(
            child: GridView.builder(
              physics: const BouncingScrollPhysics(),
              //childAspectRatio: (itemWidth / itemHeight),
              itemCount: flatList.length,
              itemBuilder: (context, index) {
                Flat flat = flatList[index];

                return makeFlat(context, index, flat);
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

  Widget makeFlat(context, index, Flat flat) {
    TextTheme appTextTheme = Theme.of(context).textTheme;
    bool isDark = Provider.of<ThemeProvider>(context).isDarkMode;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        InkWell(
          onTap: () {
            Provider.of<CurrentFlatInfoProvider>(context, listen: false)
                .currentFlatName = flat.flatName;
            flat.renter == null
                ? AppRoute.newRenterStepper(
                    context: context,
                  )
                : Navigator.of(context).push(MaterialPageRoute(
                    builder: ((builder) =>
                        FlatDetailsCopy(renter: flat.renter!))));
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
                color: Theme.of(context).primaryColor,
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
                          width: 16,
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
                        const FlatMenuPopup(),
                      ],
                    ),
                    flat.renter == null
                        ? SvgPicture.asset(
                            AppIcons.personAddUrl,
                            height: 40,
                            // width: 90,
                            color: isDark
                                ? Colors.white.withOpacity(0.6)
                                : Colors.black.withOpacity(0.6),
                          )
                        : const Text(''),
                    //BOTTOM INFORMATION ABOUT FLAT
                    flat.renter != null
                        ? ListTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  flat.renter!.renterName,
                                  maxLines: 1,
                                  overflow: TextOverflow.fade,
                                  softWrap: true,
                                ),
                                const CircleAvatar(
                                  radius: 6,
                                  backgroundColor: Colors.green,
                                ),
                              ],
                            ),
                            subtitle: Text(flat.renter != null
                                ? '${CustomFormatter().monthYear(flat.renter!.entryDate!)} থেকে আছেন'
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
            backgroundColor:
                isDark ? Colors.grey.shade900 : Colors.blue.shade200,
            radius: 22,
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
        ),
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
}
