import 'package:flutter/material.dart';

import '../../flat_info_pages/flat_detail.dart';

class FlatOptions extends StatelessWidget {
  const FlatOptions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 20),
        ListTile(
          onTap: () =>
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return const SingleFlatInfo();
          })),
          leading: const Icon(
            Icons.info_outline,
            color: Colors.pink,
          ),
          title: const Text('ফ্ল্যাটের বিস্তারিত'),
        ),
        const ListTile(
          leading: Icon(
            Icons.add,
            color: Colors.blue,
          ),
          title: Text('গ্রাহক যুক্ত'),
        ),
        const ListTile(
          leading: Icon(
            Icons.remove_circle_outline_rounded,
            color: Colors.orange,
          ),
          title: Text('গ্রাহক মুছুন'),
        ),
        const ListTile(
          leading: Icon(
            Icons.delete_outline_outlined,
            color: Colors.red,
          ),
          title: Text('ফ্ল্যাট ডিলিট'),
        ),
      ],
    );
  }
}
