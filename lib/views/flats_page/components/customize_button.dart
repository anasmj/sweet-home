import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../app_icons.dart';

//THIS BUTTON LETS USER CUSTOMIZE THEIR FLAT INFORMTAION INDIVIDUALLY
class CustomizeButton extends StatelessWidget {
  const CustomizeButton({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme appTextTheme = Theme.of(context).textTheme;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      onPressed: () {},
      child: Row(
        children: [
          Text(
            'তথ্য নির্ধারণ',
            style: appTextTheme.subtitle1,
          ),
          const SizedBox(
            width: 8,
          ),
          SvgPicture.asset(
            AppIcons().settingUrl,
            height: 20,
          )
        ],
      ),
    );
  }
}
