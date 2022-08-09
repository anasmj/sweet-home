import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../models/flat_model.dart';
import '../../../models/renter.dart';
import '../../app_icons.dart';

class AppBarContent extends StatelessWidget {
  AppBarContent({required this.renter, super.key});
  Renter? renter;
  // Renter renter;
  @override
  Widget build(BuildContext context) {
    TextTheme appTextTheme = Theme.of(context).textTheme;
    return ListTile(
      leading: const CircleAvatar(
        radius: 25,
      ),
      title: Text(
        renter!.name,
        style: appTextTheme.headline5!,
      ),
      subtitle: RichText(
        text: TextSpan(
          children: [
            TextSpan(text: 'পাবো ', style: appTextTheme.subtitle1),
            WidgetSpan(
              child: Image(
                height: 18,
                width: 18,
                color: Colors.red[700],
                image: AssetImage(AppIcons().takaUrl),
              ),
            ),
            TextSpan(
              text: '10400\n',
              style: appTextTheme.headline6!.copyWith(
                  color: Colors.red[700], fontWeight: FontWeight.w600),
            ),
            TextSpan(
                text: 'সর্বশেষঃ 12 Aug, 22', style: appTextTheme.bodyText2),
          ],
        ),
      ),
      trailing: reportButton(),
    );
  }

  Widget reportButton() => SizedBox(
        width: 100,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(),
          onPressed: () {},
          child: Row(
            children: [
              SvgPicture.asset(
                AppIcons().reportUrl,
                height: 18,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 6.0, top: 4),
                child: Text('রিপোর্ট'),
              ),
            ],
          ),
        ),
      );
}
