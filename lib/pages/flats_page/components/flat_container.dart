import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../models/flat_model.dart';
import '../../app_icons.dart';

class FlatContainer extends StatelessWidget {
  FlatContainer({
    required this.flat,
    super.key,
  });
  Flat flat;

  @override
  Widget build(BuildContext context) {
    TextTheme appTextTheme = Theme.of(context).textTheme;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.blue.withOpacity(0.4),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Image(
                  width: 20,
                  image: AssetImage(AppIcons().takaUrl),
                ),
                const SizedBox(
                  width: 6,
                ),
                SizedBox(
                  width: 70,
                  child: Text(
                    '243000',
                    style: appTextTheme.headline6,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(AppIcons().optionsUrl),
                ),
              ],
            ),
            //bottom name and profile

            ListTile(
              //leading: CircleAvatar(),
              title: Text(
                flat.renter != null ? flat.renter!.name : 'Empty flat',
                maxLines: 1,
                overflow: TextOverflow.fade,
                softWrap: true,
              ),
              subtitle: Text("2 Jun, 22 থেকে"),
            )
          ],
        ),
      ),
    );
  }
}
