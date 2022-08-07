import 'package:flutter/material.dart';
import 'components/appbar_content.dart';

class FlatDetails extends StatelessWidget {
  const FlatDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(120),
        child: AppBar(
          flexibleSpace: const Padding(
            padding: EdgeInsets.only(top: 50.0, left: 30),
            child: AppBarContent(),
          ),
        ),
      ),
    );
  }
}
