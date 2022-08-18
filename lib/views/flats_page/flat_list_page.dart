import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rent_home/models/database.dart';
import 'package:rent_home/views/flats_page/components/flat_container.dart';
import 'package:rent_home/views/shared_widgets/search_bar.dart';
import 'package:rent_home/providers/home_provider.dart';
import 'components/customize_button.dart';

class FlatListPage extends StatelessWidget {
  FlatListPage({super.key});
  @override
  Widget build(BuildContext context) {
    // final home = context.watch<HomeProvider>();
    final home = Provider.of<HomeProvider>(context);

    // home.setFlatList =
    //     databaseFlatList; //initializing list of flat in HomeProvider
    // home.flats[0].renter = ashraful;
    // print('flat List page : ${ashraful.records[0].months[2].renterFlatRent}');

    TextTheme appTextTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 40,
          ),
          //upper part of container
          Row(
            children: const [
              Expanded(
                child: SearchBar(),
              ),
              SizedBox(
                width: 10,
              ),

              //button
              CustomizeButton()
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'ফ্ল্যাট সংখ্যাঃ ',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                TextSpan(
                  text: home.flats.length.toString(),
                  style: Theme.of(context).textTheme.headline6,
                ),
              ],
            ),
          ),

          Expanded(
            child: home.flats.isNotEmpty
                ? GridView.count(
                    //childAspectRatio: (itemWidth / itemHeight),
                    childAspectRatio: 3 / 4,

                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 30,
                    children: home.flats
                        .map(
                          (e) => FlatContainer(
                            flat: e,
                          ),
                        )
                        .toList(),
                  )
                : Center(
                    child: Text(
                      'এখনও কোনও ফ্ল্যাট যুক্ত করা হয়নি',
                      style: appTextTheme.subtitle1,
                    ), //TODO: SHOW AN ADD BUTTON INSTEAD
                  ),
          ),
        ],
      ),
    );
  }
}
