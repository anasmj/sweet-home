import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sweet_home/mvvm/providers/theme_provider.dart';

// ignore: must_be_immutable
class ForwardNavButton extends StatelessWidget {
  ForwardNavButton(
      {super.key, required this.details, required this.isLastStep});
  ControlsDetails details;
  bool isLastStep;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      onPressed: details.onStepContinue,
      // provider.selectedFlatNo != null ? details.onStepContinue : null,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isLastStep ? 'যুক্ত করি' : 'সামনে যাই',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(
              width: 6,
            ),
            if (!isLastStep)
              const Icon(
                Icons.arrow_forward_rounded,
              ),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class BackNavButton extends StatelessWidget {
  BackNavButton({super.key, required this.details});
  ControlsDetails details;

  @override
  Widget build(BuildContext context) {
    bool isDark = context.watch<ThemeProvider>().isDarkMode;
    return OutlinedButton(
      style: ElevatedButton.styleFrom(
        side: BorderSide(
          color: isDark ? Colors.grey.shade400 : Colors.blue,
          width: 1,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        // backgroundColor: Colors.grey,
      ),
      onPressed: details.onStepCancel,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.arrow_back_rounded,
            ),
            SizedBox(
              width: 4,
            ),
            Text(
              'পেছনে',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
