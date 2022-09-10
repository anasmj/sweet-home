import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/models/response.dart';
import 'package:sweet_home/services/database_service/home_crud.dart';
import 'package:sweet_home/view/app_widgets.dart';
import '../../../../providers/current_home.dart';
import '../../../resources/app_icons.dart';

class DeleteButton extends StatelessWidget {
  DeleteButton({
    required this.onHomeDeleted,
    Key? key,
  }) : super(key: key);

  final String _buttonText = 'ডিলিট';
  final double _iconWidthAndHeight = 16;
  final confirmationCaptcha = 'A1B2C3';
  VoidCallback onHomeDeleted;

  @override
  Widget build(BuildContext context) {
    String currentHomeId = context.watch<CurrentHomeProvider>().currentHomeId;
    return OutlinedButton(
      onPressed: onHomeDeleted,
      style: OutlinedButton.styleFrom(
          side: const BorderSide(
        width: 1,
        color: Colors.red,
        style: BorderStyle.solid,
      )),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RichText(
            text: TextSpan(children: [
              WidgetSpan(
                child: Image.asset(
                  AppIcons.binUrl,
                  height: _iconWidthAndHeight,
                  width: _iconWidthAndHeight,
                  color: Colors.red,
                ),
              ),
              TextSpan(
                text: ' $_buttonText',
                style: const TextStyle(
                  // fontWeight: FontWeight.bold,
                  color: Colors.red,
                  fontSize: 16,
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
