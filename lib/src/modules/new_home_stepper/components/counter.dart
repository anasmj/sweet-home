import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ignore: must_be_immutable
class FlatFloorCounter extends ConsumerWidget {
  const FlatFloorCounter({
    this.titleText,
    this.onAdd,
    this.onDelete,
    this.number,
    Key? key,
  }) : super(key: key);

  final int? number;
  final String? titleText;
  final VoidCallback? onAdd, onDelete;
  @override
  Widget build(BuildContext context, ref) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              iconSize: 22,
              onPressed: onDelete,
              icon: const Icon(
                Icons.remove,
              ),
            ),
            CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor,
              child: Text(
                number.toString(),
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            IconButton(
              iconSize: 22,
              onPressed: onAdd,
              icon: const Icon(
                Icons.add,
              ),
            ),
          ],
        ),
        Text(
          titleText ?? '',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ],
    );
  }
}
