# Phase 1: Data Model Updates

## Core Application State

### `CalculatorState`
Added to support string results without breaking existing numeric flows.

```dart
class CalculatorState {
  final double currentInput;
  final double accumulator;
  final String? lastOperator;
  final bool isNewInput;
  final String? displayOverride; // NEW FIELD

  // Update constructor and copyWith to handle displayOverride
}
```

## Contracts
No external API contracts changed. Internal contract for dynamic operations (`Operation.execute`) remains `CalculatorState Function(CalculatorState)`. 
*Note: Because Bhaskara requires 3 distinct inputs from a modal rather than standard sequential input, the UI will intercept the "Bhaskara" button press, collect inputs, and can either instantiate a specific `BhaskaraOperation(a,b,c)` dynamically or handle the logic directly inside a specialized executor.*
