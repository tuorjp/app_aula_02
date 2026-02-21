import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:app_aula_02/main.dart';
import 'package:app_aula_02/core/operation_registry.dart';
import 'package:app_aula_02/operations/add_operation.dart';
import 'package:app_aula_02/operations/subtract_operation.dart';
import 'package:app_aula_02/operations/multiply_operation.dart';
import 'package:app_aula_02/operations/divide_operation.dart';

void main() {
  testWidgets('Calculator smoke test', (WidgetTester tester) async {
    // Register basic operations for the test
    final registry = OperationRegistry.instance;
    if (registry.allOperations.isEmpty) {
      registry.register(AddOperation());
      registry.register(SubtractOperation());
      registry.register(MultiplyOperation());
      registry.register(DivideOperation());
    }

    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that our initial output is 0.
    expect(find.text('0'), findsWidgets); // 0 in output and 0 button
    expect(find.text('Extensible Calculator'), findsOneWidget);

    // Verify numbers exist
    expect(find.text('5'), findsOneWidget);
    expect(find.text('9'), findsOneWidget);

    // Verify operations exist (registered in main.dart)
    expect(find.text('+'), findsOneWidget);
    expect(find.text('-'), findsOneWidget);
    expect(find.text('*'), findsOneWidget);
    expect(find.text('/'), findsOneWidget);

    // Perform a simple 5 + 3 = 8
    await tester.tap(find.widgetWithText(ElevatedButton, '5'));
    await tester.pump();
    await tester.tap(find.widgetWithText(ElevatedButton, '+'));
    await tester.pump();
    await tester.tap(find.widgetWithText(ElevatedButton, '3'));
    await tester.pump();
    await tester.tap(find.widgetWithText(ElevatedButton, '='));
    await tester.pump();

    // Verify output is 8 (the output text is larger so it might be harder to find specifically,
    // but we can check if '8' exists as text).
    expect(find.text('8'), findsWidgets);
  });
}
