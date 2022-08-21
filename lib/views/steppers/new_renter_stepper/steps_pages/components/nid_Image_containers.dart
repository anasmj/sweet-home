import 'package:flutter/material.dart';

class FrontNid extends StatelessWidget {
  const FrontNid({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          // width: 180,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black.withOpacity(0.50)),
          ),
          child: const Center(
            child: Icon(Icons.add),
          ),
        ),
        const Text('সামনে'),
      ],
    );
  }
}

class BackNid extends StatelessWidget {
  const BackNid({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          // width: 180,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black.withOpacity(0.50)),
          ),
          child: const Center(
            child: Icon(Icons.add),
          ),
        ),
        const Text('পেছনে'),
      ],
    );
  }
}
