# Phase 0: Research & Technical Decisions

## Unknowns Resolved

### How to display custom string text like "[x1, x2]" or "Sem raízes reais" on the main visor?
- **Decision**: Extend `CalculatorState` with a new optional field `final String? displayOverride;`.
- **Rationale**: The current `CalculatorState` only supports `double currentInput`. Changing the type to `dynamic` or `Object` would lose type safety (violating Constitution Principle III) and break existing binary operations (`+`, `-`, `*`, `/`). By adding a nullable string override, the UI (`CalculatorScreen`) can check if `displayOverride != null` and display that string directly in the main text widget. If null, it falls back to the standard `currentInput` double formatting. This keeps state predictable (Constitution Principle II) and isolated.
- **Alternatives considered**: 
  - Using `double.nan` and a hidden state map: Too complex and brittle.
  - Adding a separate state variable inside `_CalculatorScreenState`: Violates the pattern where `Operation.execute()` returns the full functional state.

### How to manage Bhaskara modal input?
- **Decision**: Create a stateless/stateful widget `BhaskaraInputModal` that returns `(double a, double b, double c)?` via `Navigator.pop`. The `Operation` execution will first show the dialog (requiring context), await the result, and then perform math.
- **Wait, caveat**: `Operation.execute(CalculatorState state)` is synchronous and doesn't take `BuildContext`. 
- **Revised Decision**: The UI (`CalculatorScreen`) will handle the modal interaction when the button is pressed, **before** passing the `a, b, c` values to a specialized method or operation. Actually, we might need a distinct handling for operations that require multi-input modals. We will create a robust `AdvancedOperation` or handle it specifically in the UI button callback.
