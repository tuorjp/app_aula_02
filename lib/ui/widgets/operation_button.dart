import 'package:flutter/material.dart';
import '../../core/operation.dart';

class OperationButton extends StatelessWidget {
  final Operation operation;
  final VoidCallback onPressed;

  const OperationButton({
    super.key,
    required this.operation,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(16),
        minimumSize: const Size(64, 64),
      ),
      child: Text(operation.label, style: const TextStyle(fontSize: 24)),
    );
  }
}
