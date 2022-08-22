import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/views/flats_page/components/flat_container.dart';
import 'package:sweet_home/views/app_widgets.dart';
import 'package:sweet_home/providers/home_provider.dart';
import 'components/customize_button.dart';

class FlatListPage extends StatelessWidget {
  FlatListPage({super.key});
  @override
  Widget build(BuildContext context) {
    final home = Provider.of<HomeProvider>(context);
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
            children: [
              Expanded(
                child: AppWidget.appSearchBar(),
              ),
              const SizedBox(
                width: 10,
              ),

              //button
              const CustomizeButton()
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          noOfFlatText(context, home),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: home.flats.isNotEmpty
                ? GridView.builder(
                    //childAspectRatio: (itemWidth / itemHeight),
                    itemCount: home.flats.length,
                    itemBuilder: (context, index) {
                      return FlatContainer(flatNo: index);
                    },
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 40,
                      crossAxisSpacing: 10,
                      childAspectRatio: 0.76,
                    ),
                  )
                : Center(
                    child: Text(
                      'কোনও ফ্ল্যাট যুক্ত নেই',
                      style: appTextTheme.subtitle1,
                    ), //TODO: SHOW AN ADD BUTTON INSTEAD
                  ),
          ),
        ],
      ),
    );
  }

  RichText noOfFlatText(BuildContext context, HomeProvider home) {
    return RichText(
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
    );
  }
}
