import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';

class LoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
        'assets/loading-tv.json',
      ),
    );
  }
}
