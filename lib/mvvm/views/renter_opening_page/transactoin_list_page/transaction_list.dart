import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/mvvm/models/flat_model.dart';
import 'package:sweet_home/mvvm/models/transaction.dart';
import 'package:sweet_home/mvvm/providers/selected_flat_provider.dart';
import 'package:sweet_home/mvvm/views/empty_pages/empty_tarnsaction.dart';
import 'package:sweet_home/mvvm/views/error_pages/error_page.dart';
import 'package:sweet_home/mvvm/views/renter_opening_page/transactoin_list_page/components/transaction_card.dart';

class RenterTransactions extends StatelessWidget {
  const RenterTransactions({super.key});

  @override
  Widget build(BuildContext context) {
    Flat? selectedFlat =
        Provider.of<SelectedFlatProvider>(context).selectedFlat;

    if (selectedFlat == null) return const ErrorPage();
    if (selectedFlat.renter == null) return const ErrorPage();
    if (selectedFlat.renter!.transactions == null) return const ErrorPage();
    if (selectedFlat.renter!.transactions!.isEmpty) {
      return const EmptyTransaction();
    }
    List<RenterTransaction> transactions = selectedFlat.renter!.transactions!;
    return ListView.builder(
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 22.0),
          child: TransactionCard(transaction: transactions[index]),
        );
      },
    );
  }
}
