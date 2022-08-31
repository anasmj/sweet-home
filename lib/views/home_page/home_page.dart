//* THIS IS FOLLOWED BY DESIGNE
import 'package:flutter/material.dart';
import 'package:sweet_home/models/response.dart';
import 'package:sweet_home/services/home_crud.dart';
import 'package:sweet_home/views/styling/app_icons.dart';
import '../current_month_page/current_month_details.dart';
import '../flats_page/flat_list_page.dart';
import '../pending_page/pending_page.dart';
import 'components/drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  final double _appIconHeight = 20;
  final double _appIconWidth = 20;
  final TextStyle _tabBarTextStyle = const TextStyle(fontSize: 18);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      body: DefaultTabController(
        initialIndex: 0,
        length: 3,
        child: NestedScrollView(
            headerSliverBuilder: (context, value) {
              return [
                SliverAppBar(
                  actions: [
                    IconButton(
                      onPressed: () async {
                        Response res = await HomeCrud().addHome(
                          homeName: 'sweet home',
                          location: 'Uttara',
                          rentAmount: 34000,
                          numOfFloor: 4,
                          flatPerFloor: 2,
                          gasBill: 200,
                        );
                        print(res.code);
                      },
                      icon: const Icon(Icons.add),
                    )
                  ],
                  floating: true,
                  pinned: true,
                  //pinned: true,

                  // APP BAR
                  title: const Text(
                    'আহসান মঞ্জিল ',
                    overflow: TextOverflow.fade,
                    softWrap: false,
                    // style: TextStyle(fontSize: 20),
                  ),

                  centerTitle: true,
                  //TAB BAR
                  bottom: TabBar(
                    indicatorColor: Colors.white,
                    indicatorWeight: 5,
                    tabs: [
                      Text(
                        'চলতি মাস',
                        style: _tabBarTextStyle,
                      ),
                      Text(
                        'ফ্ল্যাটগুলি',
                        style: _tabBarTextStyle,
                      ),
                      Text(
                        'বকেয়া',
                        style: _tabBarTextStyle,
                      ),
                    ],
                  ),
                ),
              ];
            },
            body: TabBarView(
              children: [
                CurrentMonthPage(),
                FlatListPage(),
                PendingPage(),
                //Expences(),
              ],
            )),
      ),
    );
  }

  Widget getIcon(String iconUrl) => SizedBox(
        height: _appIconHeight,
        width: _appIconWidth,
        child: Image(
          image: AssetImage(AppIcons.takaUrl),
        ),
      );

  //TODO: make it fancy by puttin comma between digitsz
  Widget getAmountText(int amount) => Text(' ${amount.toString()} /-');
}
