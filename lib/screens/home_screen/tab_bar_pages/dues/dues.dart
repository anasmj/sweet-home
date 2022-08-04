import 'package:flutter/material.dart';
import 'package:rent_home/screens/app_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'components/remind_button.dart';
import 'components/search_box.dart';

class Dues extends StatelessWidget {
  const Dues({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(
          height: 15,
        ),
        Text(
          'গ্রাহকের কাছ থেকে আপনার মোট বকেয়া রয়েছে',
          style: Theme.of(context)
              .textTheme
              .subtitle1!
              .copyWith(fontWeight: FontWeight.w600),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage(AppIcons().takaUrl),
              width: 20,
              height: 20,
            ),
            const SizedBox(
              width: 4,
            ),
            Text(
              '3200',
              style: Theme.of(context)
                  .textTheme
                  .headline4!
                  .copyWith(fontWeight: FontWeight.bold, color: Colors.red),
            )
          ],
        ),

        //BUTTON
        const SizedBox(
          height: 40,
          width: 180,
          child: RemindButton(),
        ),
        Row(
          children: [
            Text(
              'গ্রাহক সংখ্যা 5',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            const SizedBox(
              width: 10,
            ),
            const Expanded(
              //SEARCH BOX
              child: SearchBox(),
            ),
            IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                AppIcons().downloadUrl,
                height: 25,
                width: 25,
              ),
            )
          ],
        ),
      ]
          .map((e) => Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                child: e,
              ))
          .toList(),
    );
  }
}
