import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sweet_home/src/constants/constants.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key, this.onRetry});
  final VoidCallback? onRetry;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              AssetPath.troubleUrl,
              width: 200,
            ),
            Text(
              'কোনও একটি সমস্যা হয়েছে',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            height30,
            if (onRetry != null)
              IconButton(
                onPressed: onRetry,
                iconSize: 42,
                icon: const Icon(Icons.refresh),
              )
          ],
        ),
      ),
    );
  }
}
