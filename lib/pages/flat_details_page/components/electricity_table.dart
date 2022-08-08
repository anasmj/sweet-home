import 'package:flutter/material.dart';

class ElectricityTable extends StatelessWidget {
  const ElectricityTable({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [Text("পূর্বের ইউনিট"), Text('2033')],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [Text("বর্তমান ইউনিট"), Text('2065')],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [Text("মোট ব্যাবহৃত ইউনিট"), Text('345')],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [Text("মোট মূল্য"), Text('2033')],
          ),
        ],
      ),
    );
  }
}
