import 'dart:async';

import 'package:flutter/material.dart';

Future<void> transparentLoading(
  BuildContext context,
) async {
  unawaited(
    Navigator.of(context, rootNavigator: true).push(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => WillPopScope(
          onWillPop: () async => false,
          child: const Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          ),
        ),
        transitionDuration: Duration.zero,
        barrierDismissible: false,
        barrierColor: Colors.black45,
        opaque: false,
      ),
    ),
  );
}
