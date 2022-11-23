import 'package:flutter/material.dart';
import 'package:sweet_home/mvvm/utils/formatter.dart';
import 'package:sweet_home/mvvm/views/pendings/components/demo_renter.dart';
import 'package:sweet_home/mvvm/views/resources/app_icons.dart';
import 'components/pending_card.dart';

class AllPendingPage extends StatelessWidget {
  AllPendingPage({super.key});
  final double _lowerContainerVerticalPadding = 8;
  final double _hozontalPadding = 10;

  final Widget appBarContent = Row(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      SizedBox(
        height: 50,
        width: 50,
        child: Image.asset(AppIcons.clockUrl),
      ),
      const SizedBox(width: 10),
      Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Text(
            'মোট বকেয়া',
            style: TextStyle(fontSize: 22),
          ),
          Text(
            Formatter.toBn(value: 2312),
            style: const TextStyle(
                fontSize: 25, color: Colors.red, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ],
  );
  final Widget notificationFab = FloatingActionButton(
    backgroundColor: Colors.orange.withOpacity(0.5),
    onPressed: () {},
    child: Image(
      width: 24,
      height: 24,
      image: AssetImage(
        AppIcons.notificationUrl,
      ),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: notificationFab,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.transparent,
            expandedHeight: 100,
            flexibleSpace: FlexibleSpaceBar(background: appBarContent),
            // flexibleSpace: appBarContent,
          ),
          SliverToBoxAdapter(
            child: ListView.builder(
              primary: false,
              shrinkWrap: true,
              itemCount: DemoRenter.pendingList.length,
              itemBuilder: (context, index) {
                return Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: _lowerContainerVerticalPadding,
                        horizontal: _hozontalPadding),
                    child: PendingCard(index: index));
              },
            ),
          )
        ],
      ),
    );
  }
}
