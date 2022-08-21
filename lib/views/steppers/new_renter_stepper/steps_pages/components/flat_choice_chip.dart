import 'package:flutter/material.dart';

class FlatChoicieChips extends StatefulWidget {
  const FlatChoicieChips({super.key});

  @override
  State<FlatChoicieChips> createState() => _FlatChoicieChipsState();
}

class _FlatChoicieChipsState extends State<FlatChoicieChips> {
  int? _defaultChoiceIndex;
  bool selected = false;
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 6,
      children: List.generate(
        choiceChips.length,
        (index) => ChoiceChip(
          elevation: 4,
          backgroundColor: choiceChips[index].name != null
              ? Colors.green.withOpacity(.20)
              : Colors.red.withOpacity(.20),
          labelStyle: Theme.of(context).textTheme.subtitle1,
          labelPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
          label: choiceChips[index].name != null
              ? Text(choiceChips[index].name!)
              : const Text('empty flat'),
          avatar: CircleAvatar(
            backgroundColor: choiceChips[index].name != null
                ? Colors.green.withOpacity(0.8)
                : Colors.red.withOpacity(.80),
            radius: 14,
            child: Text(
              choiceChips[index].flatName,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
            ),
          ),
          selected: _defaultChoiceIndex == index,
          onSelected: ((bool selected) => setState(
                () {
                  _defaultChoiceIndex = selected &&
                          choiceChips[index].name ==
                              null //cant be selected where already a rente
                      ? index
                      : null;
                },
              )),
          selectedColor: choiceChips[index].name != null
              ? Colors.green.withOpacity(.40)
              : Colors.red.withOpacity(.40),
        ),
      ),
    );
  }
}

List<ChipData> choiceChips = [
  ChipData(flatName: '1A', name: 'Andrew'),
  ChipData(flatName: '1B', name: 'philip'),
  ChipData(flatName: '2A'),
  ChipData(flatName: '2B'),
  ChipData(flatName: '3A'),
  ChipData(flatName: '3B'),
];

class ChipData {
  String flatName;
  String? name;
  Color chipColor = Colors.red.withOpacity(.20);
  ChipData({required this.flatName, this.name});
}
