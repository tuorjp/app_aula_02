import '../core/operation.dart';
import '../core/calculator_state.dart';

class MultiplyOperation extends Operation {
  @override
  String get label => '*';

  @override
  CalculatorState execute(CalculatorState currentState) {
    return currentState.copyWith(
      accumulator: currentState.currentInput,
      lastOperator: label,
      isNewInput: true,
    );
  }
}
