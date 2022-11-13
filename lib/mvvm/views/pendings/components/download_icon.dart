import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sweet_home/mvvm/views/resources/app_icons.dart';

class DownloadIcon extends StatelessWidget {
  const DownloadIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {},
      icon: SvgPicture.asset(
        AppIcons.downloadUrl,
        height: 20,
        width: 20,
      ),
    );
  }
}
