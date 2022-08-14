import 'package:flutter/material.dart';

class BottomBanner extends StatelessWidget {
  const BottomBanner({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 1,
            spreadRadius: 1,
            offset: const Offset(0, 2),
          )
        ],
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).secondaryHeaderColor,
      ),
      height: 50,
      width: 180,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'বুঝে পেয়েছি 40349',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          Text(
            '23 Aug \'22d',
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ],
      ),
    );
  }
}
