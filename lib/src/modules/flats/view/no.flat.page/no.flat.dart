
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sweet_home/src/constants/asset.path.dart';

class NoFlatPage extends StatelessWidget {
  const NoFlatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(height: 30),
          SvgPicture.asset(
            AssetPath.noData2Url,
            height: 150,
          ),
          Text(
            'আপনার ফ্ল্যাটগুলি এখানে দেখতে পাবেন',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ],
      ),
    );
  }
}
