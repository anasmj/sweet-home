import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DynamicUpdateButton extends StatelessWidget {
  DynamicUpdateButton({
    Key? key,
    required this.buttonTitle,
    this.onPressed,
  }) : super(
          key: key,
        );
  VoidCallback? onPressed;
  final double buttonFontSize = 16;
  String buttonTitle;
  dynamic buttonContent;

  // FlatViewModel? flatViewModel;

  @override
  Widget build(BuildContext context) {
    // switch (status) {
    //   case Status.completed:
    //     buttonContent = updatedContent;
    //     break;
    //   case Status.loading:
    //     buttonContent = updatingContent;

    //     break;
    //   default:
    //     buttonContent = defaultContent;
    // }

    return SizedBox(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
        ),
        onPressed: onPressed,
        child: buttonContent,
      ),
    );
  }
}
