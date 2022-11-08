import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/mvvm/models/flat_model.dart';
import 'package:sweet_home/mvvm/providers/current_home.dart';
import 'package:sweet_home/mvvm/services/flat_services.dart';
import 'package:sweet_home/mvvm/views/app_widgets.dart';
import 'package:sweet_home/mvvm/views/error_pages/error_page.dart';
import 'package:sweet_home/mvvm/views/flats/components/flat_container.dart';
import 'package:sweet_home/mvvm/views/waiting_pages/searching_indicator.dart';
import '../empty_pages/empty_flat_page.dart';

class UserFlats extends StatelessWidget {
  const UserFlats({super.key});

  @override
  Widget build(BuildContext context) {
    String? homeId =
        Provider.of<CurrentHomeProvider>(context).currentHome?.homeId;
    if (homeId == null) return const NoFlatPage();
    return StreamBuilder<List<Flat>>(
      stream: FlatService().flatsStream(homeId: homeId),
      builder: (context, snapshot) {
        if (snapshot.hasError) return const ErrorPage();
        if (!snapshot.hasData) return const SearchingIndicator();
        if (snapshot.hasData) {
          List<Flat>? flats = snapshot.data;
          if (flats == null || flats.isEmpty) return const NoFlatPage();
          return showFlats(flats);
        }
        return const Scaffold();
      },
    );
  }

  Widget showFlats(List<Flat> flatList) {
    return Builder(builder: (context) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            AppWidget.appSearchBar(context: context),
            const SizedBox(height: 10),
            Expanded(
              child: GridView.builder(
                physics: const BouncingScrollPhysics(),
                //childAspectRatio: (itemWidth / itemHeight),
                itemCount: flatList.length,
                itemBuilder: (context, index) {
                  Flat flat = flatList[index];
                  return FlatContainer(flat: flat);
                },
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 60,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.76,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
