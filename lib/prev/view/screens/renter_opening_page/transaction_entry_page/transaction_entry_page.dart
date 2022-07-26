// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../../../../mvvm/models/flat_model.dart';
// import '../../../../../mvvm/providers/selected_flat_provider.dart';
// import '../../../../providers/transaction_provider.dart';
// import '../components/confirm_calculation_button.dart';
// import 'components/payer_name_button.dart';
// import 'components/transaction_date_picker.dart';
// import 'components/input_textfield.dart';
// import 'components/transaction_submit_button.dart';

// class EntryPage extends StatelessWidget {
//   const EntryPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     Flat? currentFlat = context.read<SelectedFlatProvider>().selectedFlat;
//     context.read<TransactionProvider>().payerController.text = context
//         .read<TransactionProvider>()
//         .payerName = currentFlat!.renter!.renterName;

//     return Column(
//       children: [
//         const SizedBox(
//           height: 30,
//         ),
//         const PaymentInputTextField(),
//         const Padding(
//           padding: EdgeInsets.only(top: 10.0),
//           child: TransactionDatePicker(),
//         ),
//         const SizedBox(height: 20),
//         const PayerNameButton(),
//         Text(
//           'এর মাধ্যমে',
//           style: Theme.of(context).textTheme.subtitle1,
//         ),
//         const Spacer(),
//         Padding(
//           padding: const EdgeInsets.only(bottom: 60.0),
//           child: TransactionSubmitButton(
//             text: 'বুঝে পেলাম',
//           ),
//         ),
//       ],
//     );
//   }
// }
