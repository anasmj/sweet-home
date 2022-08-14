import 'package:flutter/material.dart';

import '../../../app_icons.dart';

class InputTextField extends StatelessWidget {
  InputTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 50,
      child: TextField(
        keyboardType: TextInputType.number,
        style: Theme.of(context)
            .textTheme
            .headline5!
            .copyWith(fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(bottom: 25),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 1.0,
              color: Theme.of(context).primaryColor,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 1.2,
              color: Theme.of(context).primaryColor,
            ),
          ),
          prefixIconConstraints: const BoxConstraints(
            minHeight: 20,
            maxHeight: 30,
            minWidth: 20,
            maxWidth: 30,
          ),
          prefixIcon: Image(
            color: Colors.black.withOpacity(0.9),
            height: 10,
            image: AssetImage(
              AppIcons().takaUrl,
            ),
          ),
        ),
      ),
    );
  }
}
