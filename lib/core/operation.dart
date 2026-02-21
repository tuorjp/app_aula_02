import 'calculator_state.dart';

abstract class Operation {
  String get label;

  CalculatorState execute(CalculatorState currentState);
}
