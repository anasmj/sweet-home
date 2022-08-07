import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final String address = "skdfjjasdkfasdkf";
  final String date = "2 July, 2022";
  final String name = "Anisul Hoque";

  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // const SizedBox(
        //   height: 60,
        // ),
        Container(
            color: Colors.grey,
            child: Stack(
              children: [
                Positioned(
                  top: 100,
                  left: 30,
                  child: Text(
                    address,
                    textAlign: TextAlign.justify,
                    overflow: TextOverflow.fade,
                    maxLines: 1,
                  ),
                ),
                const Text('2 July, 2022'),
              ],
            )),
      ],
    );
  }
}
