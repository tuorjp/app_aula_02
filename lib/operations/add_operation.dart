import '../core/operation.dart';
import '../core/calculator_state.dart';

class AddOperation extends Operation {
  @override
  String get label => '+';

  @override
  CalculatorState execute(CalculatorState currentState) {
    // If there is an existing pending operator, evaluate it first?
    // For simplicity of a basic calculator, we just store the operation,
    // move currentInput to accumulator, and prepare for new input.
    return currentState.copyWith(
      accumulator: currentState.currentInput,
      lastOperator: label,
      isNewInput: true,
    );
  }
}
