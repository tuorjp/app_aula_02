import 'package:flutter/material.dart';
import 'ui/calculator_screen.dart';
import 'core/operation_registry.dart';
import 'operations/add_operation.dart';
import 'operations/subtract_operation.dart';
import 'operations/multiply_operation.dart';
import 'operations/divide_operation.dart';
import 'operations/bhaskara_operation.dart';

void main() {
  // Register basic operations
  OperationRegistry.instance.register(AddOperation());
  OperationRegistry.instance.register(SubtractOperation());
  OperationRegistry.instance.register(MultiplyOperation());
  OperationRegistry.instance.register(DivideOperation());

  // Register extra operations
  OperationRegistry.instance.register(
    BhaskaraOperation(a: 1, b: 1, c: 1),
  ); // Template instance for UI

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Extensible Calculator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: const CalculatorScreen(),
    );
  }
}
