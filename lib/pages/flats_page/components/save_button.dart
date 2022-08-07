import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../app_icons.dart';

class SaveButton extends StatelessWidget {
  const SaveButton({super.key});

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
            'সেভ',
            style: appTextTheme.subtitle1,
          ),
          const SizedBox(
            width: 8,
          ),
          SvgPicture.asset(
            AppIcons().settingUrl,
            height: 18,
          )
        ],
      ),
    );
  }
}
