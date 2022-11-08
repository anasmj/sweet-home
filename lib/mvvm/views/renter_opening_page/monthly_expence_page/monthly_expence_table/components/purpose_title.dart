import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget getPurposeTitle(
        {required String titleIcon, String title = '', Widget? widget}) =>
    Row(
      children: [
        SvgPicture.asset(
          titleIcon,
          height: 22,
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          title,
          style: const TextStyle(fontSize: 18),
        ),
        widget ?? const SizedBox.shrink()
      ],
    );
