import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sweet_home/src/modules/flats/no.flat.dart';
import 'package:sweet_home/src/providers/selected.home.provider.dart';

class FlatsPage extends ConsumerWidget {
  const FlatsPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final home = ref.watch(selectedHomeNotifier);
    if (home == null) return const NoFlatPage();
    return Container();
  }
}
