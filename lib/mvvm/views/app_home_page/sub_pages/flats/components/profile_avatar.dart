import 'package:flutter/material.dart';

import '../../../../../../prev/view/resources/app_icons.dart';

// ignore: must_be_immutable
class ProfileAvatar extends StatelessWidget {
  bool isDark;

  ProfileAvatar({
    required this.isDark,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      // backgroundColor: isDark ? Colors.grey.shade900 : Colors.blue.shade200,
      radius: 24,
      child: CircleAvatar(
          backgroundColor: Theme.of(context).secondaryHeaderColor,
          radius: 20,
          child: Image.asset(
            AppIcons.defaultProfileUrl,
            height: 20,
            width: 22,
            fit: BoxFit.cover,
          )),
    );
  }
}
