import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rent_home/pages/flats_page/components/custom_container.dart';
import 'package:rent_home/pages/shared_widgets/search_bar.dart';

import 'components/number_of_flat.dart';
import 'components/save_button.dart';

class FlatsPage extends StatelessWidget {
  const FlatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final double itemHeight =
        (size.height - kToolbarHeight - 24) / 3; // container height
    final double itemWidth = size.width / 2;
    TextTheme appTextTheme = Theme.of(context).textTheme;
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
              SaveButton()
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          const NumberOfFlat(),
          Expanded(
            child: GridView.count(
              childAspectRatio: (itemWidth / itemHeight),
              crossAxisCount: 2,
              crossAxisSpacing: 2,
              mainAxisSpacing: 10,
              children: [
                const FlatContainer(),
                Container(
                  color: Colors.blue,
                ),
                Container(
                  color: Colors.blue,
                ),
                Container(
                  color: Colors.blue,
                ),
                Container(
                  color: Colors.blue,
                ),
                Container(
                  color: Colors.blue,
                ),
                Container(
                  color: Colors.blue,
                ),
                Container(
                  color: Colors.blue,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
