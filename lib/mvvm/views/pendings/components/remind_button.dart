import 'package:flutter/material.dart';

import '../../resources/app_icons.dart';

class RemindButton extends StatelessWidget {
  const RemindButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: null,
      style: ElevatedButton.styleFrom(
          textStyle: Theme.of(context).textTheme.titleMedium,
          elevation: 8,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('মনে করিয়ে দিন'),
          const SizedBox(
            width: 10,
          ),
          Image(
            width: 20,
            height: 20,
            image: AssetImage(
              AppIcons.notificationUrl,
            ),
          )
        ],
      ),
    );
  }
}
