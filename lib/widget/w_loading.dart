import 'package:flutter/material.dart';

class WLoading extends StatelessWidget {
  const WLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
