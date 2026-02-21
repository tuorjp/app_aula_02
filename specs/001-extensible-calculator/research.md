# Research & Decisions: Extensible Calculator

## Operation Extensibility

- **Decision**: Define a base `Operation` interface with a designated `execute()` method and meta-information like `label` and `icon`. Create an `OperationRegistry` singleton or service locator that collects instances of these operations.
- **Rationale**: Meets the core requirement of avoiding UI updates. A registry allows operations to be registered independently. The UI queries the registry at runtime to generate the button grid.
- **Alternatives considered**: Passing a dynamic map into the widget directly (less maintainable, requires modifying the dependency injection graph whenever a new operation is added instead of self-registering logic if Dart supported reflection, but given Flutter's AOT limits, a centralized explicit registry approach via service locator is best).

## Single Parameter Requirement

- **Decision**: Define a `CalculatorState` object that holds current operand inputs (e.g., `double currentInput`, `double accumulator`, `String currentOperator`). The `execute` method will accept exactly one `(CalculatorState state)` and return a new `CalculatorState`.
- **Rationale**: Fulfills the FR-005 spec requirement exactly while preserving the ability to perform binary functions (like addition and subtraction) using accumulator and current input.
- **Alternatives considered**: Modifying the state in-place (mutations). Returning a new immutable state provides better predictability per Constitution Principle II.

## UI Decoupling

- **Decision**: The `CalculatorScreen` will read from the `OperationRegistry` to dynamically create a `Wrap` or `GridView` of `OperationButton` widgets.
- **Rationale**: Directly aligns with Constitution Principle I (Composition) and guarantees the UI never hardcodes operations like "+" or "-".
- **Alternatives considered**: Hardcoded layouts (rejected by spec requirements).
