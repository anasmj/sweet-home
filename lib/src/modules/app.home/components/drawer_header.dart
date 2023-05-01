import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sweet_home/src/model/home.dart';
import 'package:sweet_home/src/modules/authentication/provider/auth.notifier.dart';
import '../../../providers/user.homes.provider.dart';
import 'homes_popup.dart';

class Drawerheader extends ConsumerWidget {
  const Drawerheader({super.key});
  final double containerHeight = 200;
  @override
  Widget build(BuildContext context, ref) {
    List<Home>? userHomes;
    return Container(
      padding: const EdgeInsets.only(left: 20),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
      ),
      height: containerHeight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: ref.watch(homesProvider).when(
                  data: (data) {
                    if (data!.isNotEmpty) {
                      return Text(
                        data.first.homeName ?? '',
                        style: Theme.of(context).textTheme.titleLarge,
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                  error: (e, s) => const Text('data not found'),
                  loading: () => const CircularProgressIndicator(),
                ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const NameEmailWidget(),
                if (userHomes != null)
                  HomesPopupButton(
                    onHomeDelete: () {
                      Navigator.of(context).pop();
                    },
                    userHomes: userHomes!,
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
