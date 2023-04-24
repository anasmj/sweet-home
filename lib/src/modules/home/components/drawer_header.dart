import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers/user.homes.provider.dart';

class Drawerheader extends ConsumerWidget {
  const Drawerheader({super.key});
  final double containerHeight = 200;

  @override
  Widget build(BuildContext context, ref) {
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
            child: Text(
              'demo villa ',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          // const Spacer(),
          ref.watch(homesProvider).when(
              data: (data) {
                return Text(data.toString());
              },
              error: (e, s) => const Text('data not found'),
              loading: () => const CircularProgressIndicator()),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                getNameAndEmail(),
                // HomesPopupButton(
                //   onHomeDelete: () {
                //     Navigator.of(context).pop();
                //   },
                //   userHomes: [],
                // )
              ],
            ),
          )
        ],
      ),
    );
  }

  SizedBox getNameAndEmail() {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            // Profile.userName ?? 'Name not found',
            'Profile name',
            style: TextStyle(fontSize: 18),
          ),
          Text(
            // Profile.email ?? 'no email',
            'email',
          ),
        ],
      ),
    );
  }
}
