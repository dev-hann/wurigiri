import 'package:flutter/material.dart';

class IntroView extends StatelessWidget {
  const IntroView({super.key});

  static MaterialPageRoute<void> route() {
    return MaterialPageRoute(
      builder: (context) {
        return const IntroView();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Text("introView");
  }
}
