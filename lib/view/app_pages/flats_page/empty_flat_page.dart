import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../resources/app_icons.dart';

class NoFlatPage extends StatelessWidget {
  const NoFlatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SvgPicture.asset(
            AppIcons.noData2Url,
            height: 210,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(180, 40),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              textStyle: const TextStyle(fontSize: 20),
            ),
            onPressed: () {},
            child: const Text('ফ্ল্যাট যুক্ত করি'),
          )
        ],
      ),
    );
  }
}
