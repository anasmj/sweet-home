import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/view/app_pages/flat_info_page/flat_info_page.dart';
import 'package:sweet_home/view/app_pages/home_detail_page/update_button.dart';
import '../../../providers/current_home.dart';
import '../../../providers/theme_provider.dart';
import '../../../services/home_services.dart';
import '../../../utils/home_crud.dart';
import '../../app_widgets.dart';
import 'package:sweet_home/view/app_pages/home_detail_page/edit_textfield.dart';
import '../../resources/app_icons.dart';
import 'delete_button.dart';

class FlatInfoPage extends StatelessWidget {
  FlatInfoPage({super.key});
  final Color colorInLightMode = Colors.grey.shade700;
  final Color modalSheetBgDark = Colors.grey.shade900;
  final Color modalSheetBgLight = Colors.white;
  final Color colorInDarkMode = Colors.white;
  final double dividerHorizontalSpacing = 16;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('আপনার ফ্ল্যাটের তথ্যাবলী'),
          centerTitle: true,
          actions: [
            IconButton(
              iconSize: 18,
              onPressed: () {
                showCinfirmDialog(
                    context: context,
                    msg: 'তথ্যগুলি আপনার সকল ফ্ল্যাটের জন্য নির্ধারণ করা হবে');
              },
              icon: const Icon(Icons.info_outline),
            ),
          ],
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),

              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: dividerHorizontalSpacing),
                child:
                    flatInfoDivider(context: context, text: 'ফ্ল্যাটের তথ্য'),
              ),
              makeSingleListTile(
                context: context,
                leadingIcon: Icons.bed,
                title: 'বেড ',
                subtitleText: 'home.homeName',
                willNumeric: false,
              ),
              makeSingleListTile(
                context: context,
                leadingIcon: Icons.bathtub_outlined,
                title: 'বাথ ',
                subtitleText: 'home.homeName',
                willNumeric: false,
              ),
              makeSingleListTile(
                context: context,
                leadingIcon: Icons.camera_outdoor_outlined,
                title: 'বারান্দা ',
                subtitleText: 'home.homeName',
                willNumeric: false,
              ),
              makeSingleListTile(
                context: context,
                leadingIcon: Icons.dining_outlined,
                title: 'ডাইনিং ',
                subtitleText: 'home.homeName',
                willNumeric: false,
              ),
              makeSingleListTile(
                context: context,
                leadingIcon: Icons.chair,
                title: 'ড্রইং ',
                subtitleText: 'home.homeName',
                willNumeric: false,
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: dividerHorizontalSpacing),
                child: flatInfoDivider(context: context, text: 'বিল সমূহ'),
              ),
              makeSingleListTile(
                context: context,
                assetUrl: AppIcons.takaUrl,
                title: 'ভাড়া',
                subtitleText: 'home.homeName',
                willNumeric: false,
              ),
              makeSingleListTile(
                context: context,
                leadingIcon: Icons.gas_meter_outlined,
                title: 'গ্যাস',
                subtitleText: 'home.homeName',
                willNumeric: false,
              ),
              makeSingleListTile(
                context: context,
                leadingIcon: Icons.water_drop_outlined,
                title: 'পানি',
                subtitleText: 'home.homeName',
                willNumeric: false,
              ),
              const SizedBox(
                height: 10,
              ),
              //delete flat if renter does not exist
              DeleteButton(),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ));
  }

  Future<void> showCinfirmDialog(
      {required BuildContext context,
      required String msg,
      String title = ''}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          // title: Text(title),

          content: Text(
            msg,
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'ঠিক আছে',
                style: TextStyle(fontSize: 16),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Row flatInfoDivider({required BuildContext context, String text = ''}) {
    return Row(
      children: [
        Text(
          text,
          style: Theme.of(context).textTheme.subtitle1,
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Divider(
            thickness: 2,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ],
    );
  }

  ListTile makeSingleListTile({
    required BuildContext context,
    IconData? leadingIcon,
    required String title,
    required String subtitleText,
    bool isDouble = false,
    bool isInt = false,
    String? Function(String?)? validationFunciton,
    String? assetUrl,
    bool? willNumeric = true,
    bool isTappable = true,
  }) {
    bool isDark = context.watch<ThemeProvider>().isDarkMode;
    CurrentHomeProvider providerRead = context.read<CurrentHomeProvider>();
    return ListTile(
      onTap: !isTappable
          ? null
          : () {
              providerRead.displayTextController.text = subtitleText;
              showModalBottomSheet(
                backgroundColor: isDark ? modalSheetBgDark : modalSheetBgLight,
                isScrollControlled: true,
                shape: modalSheetStyle(),
                context: context,
                // isScrollControlled: true,
                builder: (context) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.75,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0, bottom: 30),
                          child: modalSheetDivider(isDark),
                        ),
                        Text(
                          title,
                          style: const TextStyle(fontSize: 24),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: Form(
                            key:
                                context.read<CurrentHomeProvider>().editFormKey,
                            child: EditTextField(
                              validationFunciton: validationFunciton,
                              isNumeric: willNumeric ?? false,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        UpdateButton(
                          onUpdated: () {},
                        ),
                      ],
                    ),
                  );
                },
              );
            },
      leading: assetUrl == null
          ? Icon(
              leadingIcon,
              color: isDark ? colorInDarkMode : colorInLightMode,
            )
          //asset used instead of icon in 'Rent Amount'
          : Image.asset(
              assetUrl,
              height: 20,
              color: isDark ? colorInDarkMode : colorInLightMode,
            ),
      title: Text(title),
      subtitle: Text(
        subtitleText.toString(),
        style: TextStyle(
          color: isDark ? colorInDarkMode : colorInLightMode,
        ),
      ),
    );
  }

  RoundedRectangleBorder modalSheetStyle() {
    return const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    );
  }

  Container modalSheetDivider(bool isDarkMode) {
    return Container(
      decoration: ShapeDecoration(
        shape: const StadiumBorder(),
        color: isDarkMode ? Colors.white60 : Colors.grey.shade700,
      ),
      height: 4,
      width: 20,
    );
  }
}
