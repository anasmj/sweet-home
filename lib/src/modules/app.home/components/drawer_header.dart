import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sweet_home/src/extensions/extensions.dart';
import 'package:sweet_home/src/modules/authentication/provider/auth.notifier.dart';
import 'package:sweet_home/src/providers/selected.home.provider.dart';
import 'package:sweet_home/src/providers/user.homes.provider.dart';

import 'homes_popup.dart';

class Drawerheader extends ConsumerWidget {
  const Drawerheader({super.key});
  final double containerHeight = 200;
  @override
  Widget build(BuildContext context, ref) {
    final selectedHome = ref.watch(selectedHomeProvider);
    return Container(
      padding: const EdgeInsets.only(left: 20),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
      ),
      height: containerHeight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(height: 70),
          Text(
            selectedHome?.homeName ?? '',
            style: context.text.titleLarge,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const NameEmailWidget(),
                ref.watch(homesProvider).when(
                      data: (homes) {
                        if (homes != null && homes.length > 1) {
                          return HomesPopupButton(
                            onHomeDelete: () {
                              Navigator.of(context).pop();
                            },
                            userHomes: homes,
                          );
                        } else {
                          return emptyWidget;
                        }
                      },
                      error: (e, s) => emptyWidget,
                      loading: () => emptyWidget,
                    )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class NameEmailWidget extends ConsumerWidget {
  const NameEmailWidget({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final currentUser = ref.watch(appUserNotifier.notifier).currentUser;
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            currentUser?.name ?? '',
            style: const TextStyle(fontSize: 18),
          ),
          Text(
            currentUser?.email ?? '',
          ),
        ],
      ),
    );
  }
}
