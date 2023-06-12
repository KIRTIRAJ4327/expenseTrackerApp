import 'package:flutter/material.dart';

class BottomSheet extends StatelessWidget {
  VoidCallback? _openAddExpenseOverlay(context) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => const Text('Modal bottom sheet'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
