import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sweet_home/src/api/flat_services.dart';
import 'package:sweet_home/src/components/app.widgets/app.widgets.dart';
import 'package:sweet_home/src/components/error.page/error_page.dart';
import 'package:sweet_home/src/components/searching.indicator/searching_indicator.dart';
import 'package:sweet_home/src/model/flat.dart';
import 'package:sweet_home/src/modules/flats/provider/selected.flat.provider.dart';
import 'package:sweet_home/src/modules/flats/view/no.flat.page/no.flat.dart';
import 'package:sweet_home/src/providers/selected.home.provider.dart'; 
import '../../components/flat.container/flat_container.dart';

class FlatsPage extends ConsumerWidget {
  const FlatsPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final home = ref.watch(selectedHomeNotifier);
    if (home == null) return const NoFlatPage();
    if (home.homeId == null) return const NoFlatPage();
    return StreamBuilder<List<Flat>>(
      stream: FlatService().flatsStream(homeId: home.homeId!),
      builder: (context, snapshot) {
        if (snapshot.hasError) return const ErrorPage();
        if (!snapshot.hasData) return const SearchingIndicator();
        if (snapshot.hasData) {
          List<Flat>? flats = snapshot.data;
          if (flats == null || flats.isEmpty) return const NoFlatPage();
          // return showFlats(flats);
          return Builder(
            builder: (context) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 50),
                    AppWidget.appSearchBar(context: context),
                    const SizedBox(height: 10),
                    Expanded(
                      child: GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        //childAspectRatio: (itemWidth / itemHeight),
                        itemCount: flats.length,
                        itemBuilder: (context, index) {
                          return FlatContainer(
                            flat: flats[index],
                            onFlatTap: () => ref
                                .read(selectedFlatNotifier.notifier)
                                .onSelect(
                                  context,
                                  flat: flats[index],
                                ),
                            onFlatLongPress: () => ref
                                .read(selectedFlatNotifier.notifier)
                                .onLongPress(
                                  context,
                                  flat: flats[index],
                                ),
                          );
                        },
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 60,
                          crossAxisSpacing: 12,
                          childAspectRatio: 0.76,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }
        return const Scaffold();
      },
    );
  }
}
