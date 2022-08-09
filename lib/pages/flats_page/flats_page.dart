import 'package:flutter/material.dart';
import 'package:rent_home/pages/flats_page/components/flat_container.dart';
import 'package:rent_home/pages/shared_widgets/search_bar.dart';
import '../../models/demo_database.dart';
import 'components/customize_button.dart';

class FlatsPage extends StatelessWidget {
  const FlatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // final double itemHeight =
    //     (size.height - kToolbarHeight - 24) / 3; // container height
    // final double itemWidth = size.width / 2;
    // TextTheme appTextTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  text: flatList.length.toString(),
                  style: Theme.of(context).textTheme.headline6,
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.count(
              //childAspectRatio: (itemWidth / itemHeight),
              childAspectRatio: 3 / 4,

              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 30,
              children: flatList
                  .map((e) => FlatContainer(
                        flat: e,
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
