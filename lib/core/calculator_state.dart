class CalculatorState {
  final double currentInput;
  final double accumulator;
  final String? lastOperator;
  final bool isNewInput;
  final String? displayOverride;

  CalculatorState({
    required this.currentInput,
    required this.accumulator,
    this.lastOperator,
    required this.isNewInput,
    this.displayOverride,
  });

  factory CalculatorState.initial() {
    return CalculatorState(
      currentInput: 0,
      accumulator: 0,
      lastOperator: null,
      isNewInput: true,
      displayOverride: null,
    );
  }

  CalculatorState copyWith({
    double? currentInput,
    double? accumulator,
    String? lastOperator,
    bool? isNewInput,
    bool clearLastOperator = false,
    String? displayOverride,
    bool clearDisplayOverride = false,
  }) {
    return CalculatorState(
      currentInput: currentInput ?? this.currentInput,
      accumulator: accumulator ?? this.accumulator,
      lastOperator: clearLastOperator
          ? null
          : (lastOperator ?? this.lastOperator),
      isNewInput: isNewInput ?? this.isNewInput,
      displayOverride: clearDisplayOverride
          ? null
          : (displayOverride ?? this.displayOverride),
    );
  }
}
