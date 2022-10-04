import 'package:flutter/material.dart';

Widget buildChips() => Wrap(
      children: const [
        ChoiceChip(
          selected: true,
          elevation: 3,
          avatar: CircleAvatar(
            backgroundColor: Colors.green,
            child: Text('1A'),
          ),
          label: Text('আশরাফুল আলম'),
        ),
        Chip(
          elevation: 3,
          avatar: CircleAvatar(
            backgroundColor: Colors.green,
            child: Text('1B'),
          ),
          label: Text('রবিউল ইসলাম'),
        ),
        Chip(
          elevation: 3,
          avatar: CircleAvatar(
            backgroundColor: Colors.green,
            child: Text('2A'),
          ),
          label: Text('মাইনুল হোসেন'),
        ),
        Chip(
          elevation: 3,
          avatar: CircleAvatar(
            backgroundColor: Colors.green,
            child: Text('2B'),
          ),
          label: Text('সাইফুল'),
        ),
      ],
    );
