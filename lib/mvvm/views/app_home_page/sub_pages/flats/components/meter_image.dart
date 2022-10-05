import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../../prev/view/resources/app_icons.dart';
import '../../../../../utils/enums.dart';

// ignore: must_be_immutable
class MeterImage extends StatelessWidget {
  MeterIndicatorType meterIndicatorType;
  MeterImage({
    required this.meterIndicatorType,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    bool isPrevious = meterIndicatorType == MeterIndicatorType.previousReading;
    return AspectRatio(
      aspectRatio: 2 / 0.8,
      child: Center(
        child: SizedBox(
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.topRight,
            children: [
              Image.asset(
                AppIcons.meterUrl,
              ),
              Positioned(
                top: -8,
                right: 6,
                child: isPrevious ? getRedCircle() : getPendingCircle(),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget getPendingCircle() => const CircleAvatar(
        radius: 10,
        backgroundColor: Colors.orange,
        child: Icon(
          FontAwesomeIcons.ellipsis,
          color: Colors.white,
          size: 14,
        ),
      );

  CircleAvatar getRedCircle() {
    return const CircleAvatar(
      radius: 10,
      backgroundColor: Colors.red,
      child: Icon(
        Icons.question_mark_outlined,
        size: 16,
        color: Colors.white,
      ),
    );
  }
}
