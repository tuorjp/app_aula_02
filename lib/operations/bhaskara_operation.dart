import 'dart:math';
import '../../core/calculator_state.dart';
import '../../core/operation.dart';

class BhaskaraOperation implements Operation {
  final double a;
  final double b;
  final double c;

  BhaskaraOperation({required this.a, required this.b, required this.c});

  @override
  String get label => 'Bhaskara';

  @override
  CalculatorState execute(CalculatorState state) {
    if (a == 0) {
      return state.copyWith(displayOverride: "Erro: a=0", isNewInput: true);
    }

    final delta = (b * b) - (4 * a * c);

    if (delta < 0) {
      return state.copyWith(
        displayOverride: "Sem raízes reais",
        isNewInput: true,
      );
    }

    final x1 = (-b + sqrt(delta)) / (2 * a);
    final x2 = (-b - sqrt(delta)) / (2 * a);

    // Formatting precisely, skipping decimals if not needed
    String format(double val) {
      String s = val.toStringAsFixed(2);
      if (s.endsWith('.00')) {
        s = s.substring(0, s.length - 3);
      } else if (s.endsWith('0')) {
        s = s.substring(0, s.length - 1);
      }
      return s;
    }

    return state.copyWith(
      displayOverride: "[${format(x1)}, ${format(x2)}]",
      isNewInput: true,
      clearLastOperator: true,
    );
  }
}
