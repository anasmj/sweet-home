import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AuthenticateButton extends StatelessWidget {
  AuthenticateButton({
    super.key,
    required this.onPressed,
    required this.buttonText,
    this.iconData,
    this.isFilled = false,
    this.faIcon,
  });
  final IconData? iconData;
  final FaIcon? faIcon;
  final String buttonText;
  final bool isFilled;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: isFilled
            ? FilledButton(
                onPressed: onPressed,
                child: getButtonText(buttonText),
              )
            : OutlinedButton(
                onPressed: onPressed,
                style: _outlineButtonStyle,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    faIcon ?? const SizedBox.shrink(),
                    SizedBox(width: faIcon == null ? 0 : 10),
                    getButtonText(buttonText),
                  ],
                ),
              ),
      ),
    );
  }

  final _outlineButtonStyle = OutlinedButton.styleFrom(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30),
    ),
    side: const BorderSide(
      color: Colors.blue,
      width: 2,
    ),
  );

  Text getButtonText(String txt) =>
      Text(txt, style: const TextStyle(fontSize: 18));
}
