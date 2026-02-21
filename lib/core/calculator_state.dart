class CalculatorState {
  final double currentInput;
  final double accumulator;
  final String? lastOperator;
  final bool isNewInput;

  CalculatorState({
    required this.currentInput,
    required this.accumulator,
    this.lastOperator,
    required this.isNewInput,
  });

  factory CalculatorState.initial() {
    return CalculatorState(
      currentInput: 0,
      accumulator: 0,
      lastOperator: null,
      isNewInput: true,
    );
  }

  CalculatorState copyWith({
    double? currentInput,
    double? accumulator,
    String? lastOperator,
    bool? isNewInput,
    bool clearLastOperator = false,
  }) {
    return CalculatorState(
      currentInput: currentInput ?? this.currentInput,
      accumulator: accumulator ?? this.accumulator,
      lastOperator: clearLastOperator
          ? null
          : (lastOperator ?? this.lastOperator),
      isNewInput: isNewInput ?? this.isNewInput,
    );
  }
}
