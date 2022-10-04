import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/mvvm/providers/current_home.dart';
import 'package:sweet_home/mvvm/view_models/flat_list_view_model.dart';
import 'package:sweet_home/mvvm/views/empty_pages/empty_flat_page.dart';

class FlatsPage extends StatefulWidget {
  const FlatsPage({super.key});

  @override
  State<FlatsPage> createState() => _FlatsPageState();
}

class _FlatsPageState extends State<FlatsPage> {
  late FlatListViewModel flatListViewModel;
  late CurrentHomeProvider currentHomeProvider;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    flatListViewModel = Provider.of<FlatListViewModel>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text('flats')),
    );
  }
}
