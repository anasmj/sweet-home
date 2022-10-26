import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/mvvm/providers/theme_provider.dart';

import 'back_button.dart';

class ProfileAppBar extends StatelessWidget {
  const ProfileAppBar({
    Key? key,
  }) : super(key: key);

  final double profileImageRadius = 60;
  final double containerHeight = 180;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      clipBehavior: Clip.none,
      children: [
        Container(
          color: Theme.of(context).appBarTheme.backgroundColor,
          height: containerHeight,
        ),
        Positioned(
          top: 40,
          child: Text(
            'Profile',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        // getBackButton(context),
        const Positioned(
          top: 30,
          left: 10,
          child: ProfileBackButton(),
        ),
        Positioned(
          bottom: -containerHeight / 4,
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: profileImageRadius,
                    backgroundColor: Theme.of(context).primaryColor,
                    child: const Icon(
                      Icons.person,
                      size: 50,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: context.read<ThemeProvider>().isDarkMode
                          ? Colors.grey.shade600
                          : Colors.blue,
                      child: const Icon(
                        Icons.add,
                        size: 26,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
