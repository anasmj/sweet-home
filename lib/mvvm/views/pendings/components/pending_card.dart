import 'package:flutter/material.dart';
import 'package:sweet_home/mvvm/views/pendings/components/demo_renter.dart';
import 'package:sweet_home/mvvm/views/resources/app_icons.dart';
import 'package:sweet_home/mvvm/views/resources/image_urls.dart';

class PendingCard extends StatelessWidget {
  const PendingCard({super.key, this.index = 0});
  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 3,
      color: Colors.blue[50],
      child: Stack(
        alignment: Alignment.center,
        children: [
          getListTile(context, DemoRenter.pendingList[index], index),
          Padding(
            //! 10 pixels for displaying pending amound in card
            padding: const EdgeInsets.only(right: 14.0),
            child: getDueAmountText(context, DemoRenter.pendingList[index]),
          ),
        ],
      ),
    );
  }

  ListTile getListTile(BuildContext context, DemoRenter renter, int index) {
    return ListTile(
      // isThreeLine: true,
      leading: CircleAvatar(
        radius: 25,
        backgroundColor: Colors.blue,
        backgroundImage: NetworkImage(ImageUrl.imageList[index]),
      ),
      title: Text(
        renter.name,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      subtitle: Text(
        'সর্বশেষ লেনদেনঃ ${renter.time}',
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }

  Row getDueAmountText(BuildContext context, DemoRenter renter) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Image(
          width: 15,
          height: 15,
          image: AssetImage(AppIcons.takaUrl),
        ),
        const SizedBox(
          width: 2,
        ),
        SizedBox(
          width: 70,
          child: Text(
            renter.amount.toString(), // more than one lak will give overflwo
            style: Theme.of(context).textTheme.titleLarge,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            // softWrap: true,
          ),
        ),
      ],
    );
  }
}
