import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/mvvm/utils/enums.dart';
import 'package:sweet_home/mvvm/view_models/flat_view_model.dart';
import 'package:sweet_home/mvvm/view_models/home_list_view_model.dart';

// ignore: must_be_immutable
class DynamicUpdateButton extends StatelessWidget {
  DynamicUpdateButton(
      {Key? key,
      required this.buttonTitle,
      this.onPressed,
      required this.scope})
      : super(key: key);
  VoidCallback? onPressed;
  final double buttonFontSize = 16;
  String buttonTitle;
  dynamic buttonContent;
  Scope scope;
  // FlatViewModel? flatViewModel;

  @override
  Widget build(BuildContext context) {
    Status status;
    if (scope == Scope.flat) {
      status = context.watch<FlatViewModel>().status;
    } else {
      status = context.watch<HomeListViewModel>().status;
    }

    Widget updatedContent = Row(
      mainAxisSize: MainAxisSize.min,
      children: const [
        Icon(
          Icons.check_circle,
          color: Colors.white,
          size: 19,
        ),
        SizedBox(width: 5),
        Text(
          'আপডেট করা হয়েছে',
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
    Widget updatingContent = const SizedBox(
      height: 16,
      width: 16,
      child: CircularProgressIndicator(
        color: Colors.white,
        strokeWidth: 2.0,
      ),
    );
    Widget defaultContent = const Text(
      'আপডেট করুন',
      style: TextStyle(fontSize: 16),
    );
    switch (status) {
      case Status.completed:
        buttonContent = updatedContent;
        break;
      case Status.loading:
        buttonContent = updatingContent;

        break;
      default:
        buttonContent = defaultContent;
    }

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
