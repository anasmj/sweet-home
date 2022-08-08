import 'package:flutter/material.dart';

import '../../app_icons.dart';

class InputTextField extends StatelessWidget {
  const InputTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 140,
      child: TextField(
        keyboardType: TextInputType.number,
        style: Theme.of(context)
            .textTheme
            .headline5!
            .copyWith(fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(
            left: 10,
          ), //TODO: content padding not working
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(width: 1.6),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(width: 1.6),
          ),
          prefixIconConstraints: const BoxConstraints(
            minHeight: 20,
            maxHeight: 30,
            minWidth: 20,
            maxWidth: 30,
          ),
          prefixIcon: Image(
            height: 12,
            image: AssetImage(
              AppIcons().takaUrl,
            ),
          ),
        ),
      ),
    );
  }
}
