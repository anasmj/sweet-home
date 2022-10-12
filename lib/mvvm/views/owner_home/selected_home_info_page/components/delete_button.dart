import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/mvvm/models/response.dart';
import 'package:sweet_home/mvvm/view_models/home_list_view_model.dart';
import 'package:sweet_home/mvvm/views/app_widgets.dart';

import '../../../resources/app_icons.dart';

class DeleteButton extends StatelessWidget {
  DeleteButton({
    Key? key,
  }) : super(key: key);

  final String _buttonText = 'ডিলিট';
  final double _iconWidthAndHeight = 16;
  final confirmationCaptcha = 'A1B2C3';

  @override
  Widget build(BuildContext context) {
    Response response;
    final provider = Provider.of<HomeListViewModel>(context);
    return TextButton(
      onPressed: () async {
        response = await provider.onHomeDeleted();
        if (response.code == 200) {
          AppWidget.snackBarContent(msg: 'বাড়ীটি মুছে ফেলা হয়েছে');
          await provider.getUserHomes();
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
