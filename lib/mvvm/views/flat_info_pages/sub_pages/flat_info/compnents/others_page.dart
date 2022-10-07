import 'package:flutter/material.dart';

class OtherExpences extends StatelessWidget {
  List<Map<String, dynamic>>? othersList;
  OtherExpences({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('অন্যান্য '),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      body: othersList != null ? showList() : const SizedBox.shrink(),
    );
  }

  showList() {}
}
