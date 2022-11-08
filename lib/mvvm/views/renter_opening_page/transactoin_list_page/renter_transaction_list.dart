import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/mvvm/models/flat_model.dart';
import 'package:sweet_home/mvvm/models/transaction.dart';
import 'package:sweet_home/mvvm/providers/current_home.dart';
import 'package:sweet_home/mvvm/providers/selected_flat_provider.dart';
import 'package:sweet_home/mvvm/services/flat_services.dart';
import 'package:sweet_home/mvvm/views/empty_pages/empty_tarnsaction.dart';
import 'package:sweet_home/mvvm/views/error_pages/error_page.dart';
import 'package:sweet_home/mvvm/views/renter_opening_page/transactoin_list_page/components/transaction_card.dart';

class RenterTransactions extends StatelessWidget {
  const RenterTransactions({super.key});

  @override
  Widget build(BuildContext context) {
    String? selectedFlat =
        context.watch<SelectedFlatProvider>().selectedFlat?.flatName;
    String? homeId =
        Provider.of<CurrentHomeProvider>(context).currentHome?.homeId;
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
          List<RenterTransaction>? transactionList = flat?.renter?.transactions;
          if (transactionList == null) {
          } else {
            if (transactionList.isEmpty) return const EmptyTransaction();
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: transactionList.length,
              itemBuilder: (context, index) {
                int reversedIndex = transactionList.length - 1 - index;
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 22.0, horizontal: 12.0),
                  child: TransactionCard(
                      transaction: transactionList[reversedIndex]),
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
