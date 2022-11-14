import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/mvvm/models/response.dart';
import 'package:sweet_home/mvvm/utils/dialogs.dart';
import 'package:sweet_home/mvvm/view_models/home_list_view_model.dart';
import 'package:sweet_home/mvvm/views/app_widgets.dart';

import '../../../resources/app_icons.dart';

// ignore: must_be_immutable
class DeleteButton extends StatelessWidget {
  DeleteButton({
    Key? key,
    this.honeInfoPageContext,
  }) : super(key: key);

  final String _buttonText = 'ডিলিট';
  final double _iconWidthAndHeight = 16;
  final confirmationCaptcha = 'A1B2C3';
  BuildContext? honeInfoPageContext;
  @override
  Widget build(BuildContext context) {
    Response response;
    final provider = Provider.of<HomeListViewModel>(context);
    return TextButton(
      onPressed: () async {
        AppDialog().showLoadingDialog(
            context: context, msg: 'বাড়ীটি সরিয়ে ফেলা হচ্ছে . . ');
        response = await provider.deleteHome();
        // ignore: use_build_context_synchronously
        Navigator.pop(context);

        if (response.code != 200) {
          AppWidget.showSnackBarWithMsg(
              msg: 'কোনও একটি সমস্যা হয়েছে\nError: ${response.body}');
          // ignore: use_build_context_synchronously
          if (honeInfoPageContext != null) {
            Navigator.pop(honeInfoPageContext!);
          }
        }
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RichText(
            text: TextSpan(
              children: [
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
