import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/mvvm/providers/theme_provider.dart';

// ignore: must_be_immutable
class FlatInfoDivider extends StatelessWidget {
  final dividerColorDark = Colors.grey.shade300;
  final dividerColorLight = Colors.grey.shade600;
  FlatInfoDivider(
      {this.title, this.iconColor = Colors.grey, this.icon, super.key});
  IconData? icon;
  Color iconColor;
  String? title;
  @override
  Widget build(BuildContext context) {
    bool isDark = Provider.of<ThemeProvider>(context).isDarkMode;
    return Row(
      children: [
        icon != null
            ? Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Icon(
                  icon,
                  color: iconColor,
                ),
              )
            : const SizedBox.shrink(),
        Text(
          title ?? '',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Divider(
            thickness: 2,
            color: isDark ? dividerColorLight : dividerColorDark,
          ),
        ),
      ],
    );
  }
}
