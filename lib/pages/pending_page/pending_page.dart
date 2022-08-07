import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../app_icons.dart';
import 'components/remind_button.dart';
import '../shared_widgets/search_bar.dart';

class PendingPage extends StatelessWidget {
  const PendingPage({super.key});
  final double _hozontalPadding = 10;
  final double _upperContainerVerticalPadding = 10;
  final double _lowerContainerVerticalPadding = 8;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //UPPER SCREEN
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 15,
            ),
            Text(
              'গ্রাহকের কাছ থেকে আপনার মোট বকেয়া',
              style: Theme.of(context)
                  .textTheme
                  .subtitle1!
                  .copyWith(fontWeight: FontWeight.w600),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  color: Colors.red,
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
            const SizedBox(),
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
                  child: SearchBar(),
                ),
                IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(
                    AppIcons().downloadUrl,
                    height: 20,
                    width: 20,
                  ),
                )
              ],
            ),
          ]
              .map((e) => Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: _upperContainerVerticalPadding,
                        horizontal: _hozontalPadding),
                    child: e,
                  ))
              .toList(),
        ),

        //LOWER SCREEN containes list of user who has dues
        Expanded(
          child: ListView.builder(
            itemCount: 20,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(
                    vertical: _lowerContainerVerticalPadding,
                    horizontal: _hozontalPadding),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  elevation: 3,
                  color: Colors.blue[50],
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      ListTile(
                        // isThreeLine: true,
                        leading: const CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.blue,
                        ),
                        title: Text(
                          'রিফাত আহমেদ',
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        subtitle: Text(
                          'সর্বশেষ লেনদেনঃ 03:17 pm',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                      Padding(
                        //! 10 pixels for displaying pending amound in card
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Image(
                              width: 15,
                              height: 15,
                              image: AssetImage(AppIcons().takaUrl),
                            ),
                            const SizedBox(
                              width: 2,
                            ),
                            SizedBox(
                              width: 70,
                              child: Text(
                                '10000', // more than one lak will give overflwo
                                style: Theme.of(context).textTheme.headline6,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                // softWrap: true,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
