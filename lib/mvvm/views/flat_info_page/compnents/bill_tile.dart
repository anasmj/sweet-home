import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/mvvm/models/theme_provider.dart';

// ignore: must_be_immutable
class BillTile extends StatelessWidget {
  BillTile({
    super.key,
    this.leadingIcon,
    required this.title,
    this.subTitle,
    this.trailing,
    this.isDouble = false,
    this.isInt = false,
    this.validationFuction,
    this.isNumeric = true,
    this.isTappable = true,
    this.onClick,
  });
  final Color colorInDarkMode = Colors.white;
  final Color colorInLightMode = Colors.grey.shade700;
  VoidCallback? onClick;

  IconData? leadingIcon;
  String title;
  String? subTitle;
  bool isDouble;
  bool isInt;
  String? Function(String?)? validationFuction;
  String? assetUrl;
  bool? isNumeric = true;
  bool? isTappable = true;
  Widget? trailing;
  @override
  Widget build(BuildContext context) {
    bool isDark = Provider.of<ThemeProvider>(context).isDarkMode;
    return ListTile(
      onTap: onClick,
      title: Text(title),
      subtitle: Text(subTitle ?? ''),
      leading: Icon(
        leadingIcon,
        color: isDark ? colorInDarkMode : colorInLightMode,
      ),
      trailing: trailing,
    );
  }
}
