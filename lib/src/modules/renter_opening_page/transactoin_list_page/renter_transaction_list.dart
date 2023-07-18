import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sweet_home/src/api/flat_services.dart';
import 'package:sweet_home/src/components/error.page/error_page.dart';
import 'package:sweet_home/src/extensions/extensions.dart';
import 'package:sweet_home/src/model/flat.dart';
import 'package:sweet_home/src/model/transaction.dart';
import 'package:sweet_home/src/modules/flats/provider/selected.flat.provider.dart';
import 'package:sweet_home/src/providers/selected.home.provider.dart';

import '../components/transaction.card.dart';

class RenterTransactions extends ConsumerWidget {
  const RenterTransactions({super.key});

  @override
  Widget build(BuildContext context, ref) {
    String? selectedFlat = ref.watch(selectedFlatProvider)?.flatName;
    String? homeId = ref.watch(selectedHomeProvider)?.homeId;
    if (selectedFlat == null || homeId == null) return const ErrorPage();

    return StreamBuilder<Flat>(
      stream: FlatService()
          .selectedFlatSteram(homeId: homeId, flatId: selectedFlat),
      builder: (context, snapshot) {
        if (snapshot.hasError) return const ErrorPage();
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasData) {
          Flat? flat = snapshot.data;
          List<RenterTransaction>? transactionList = [];
          if (transactionList == null) {
            return emptyWidget;
          } else {
            if (transactionList.isEmpty) return emptyWidget;
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: transactionList.length,
              itemBuilder: (context, index) {
                int reversedIndex = transactionList.length - 1 - index;
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 22.0, horizontal: 12.0),
                  child: TransactionCard(
                    renterTransaction: transactionList[reversedIndex],
                  ),
                );
              },
            );
          }
        }
        return const SizedBox.shrink();
      },
    );
  }
}
