import 'package:flutter/material.dart';

class EmptyShowList extends StatelessWidget {
  const EmptyShowList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('No show was found!'),
    );
  }
}
