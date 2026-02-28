# Implementation Plan: Bhaskara Operation

**Branch**: `002-bhaskara-operation` | **Date**: 2026-02-27 | **Spec**: [spec.md](spec.md)
**Input**: Feature specification from `/specs/002-bhaskara-operation/spec.md`

## Summary

Implement a new calculator operation to solve the Bhaskara formula (quadratic equations). This requires a dedicated button on the UI, a modal for inputting coefficients (a, b, c), and displaying the roots as a text string (e.g., "[x1, x2]") on the main visor, while properly handling negative discriminants with a "Sem raízes reais" error message.

## Technical Context

**Language/Version**: Dart 3 (Flutter)
**Primary Dependencies**: Flutter SDK, built-in `dart:math`
**Storage**: N/A
**Testing**: `flutter test` (Unit/Widget tests)
**Target Platform**: Android, iOS, Web
**Project Type**: mobile  
**Performance Goals**: Instantaneous calculation (<16ms frame drop)
**Constraints**: Must integrate cleanly with the existing extensible `Operation` registry and `CalculatorState` without breaking previous operations.
**Scale/Scope**: Addition of one new operation class, one input modal widget, and minor UI state handling for string formatting.

**Identified Unknowns**:
- `NEEDS CLARIFICATION`: The current `CalculatorState`'s `currentInput` is a `double`, but the spec requires displaying a text string like "[x1, x2]" or "Sem raízes reais". We need to research the best way to modify `CalculatorState` or the display logic to support text without violating strict typing or breaking existing numerical operations.

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

- **I. Composition Over Monoliths**: Yes. We will enforce this by extracting the Bhaskara input dialog into its own stateless/stateful widget (`BhaskaraInputModal`) rather than bloating `CalculatorScreen`.
- **II. Predictable State Management**: Yes. The `CalculatorState` flow will remain unidirectional. However, the exact mechanism for string representation needs research (Phase 0).
- **III. Strict Type Safety & Analysis**: Yes. All new operations and widgets will be strongly typed. We will ensure `flutter analyze` passes.

## Project Structure

### Documentation (this feature)

```text
specs/002-bhaskara-operation/
├── plan.md              
├── research.md          
├── data-model.md        
├── quickstart.md        
├── contracts/           
└── tasks.md             
```

### Source Code (repository root)

```text
# Option 1: Single project (mobile app)
lib/
├── core/
│   ├── calculator_state.dart
│   └── operation.dart
├── operations/
│   └── bhaskara_operation.dart
└── ui/
    ├── calculator_screen.dart
    └── widgets/
        ├── operation_button.dart
        └── bhaskara_input_modal.dart

test/
└── widget_test.dart
```

**Structure Decision**: Selected Option 1 (Single project), integrating the new feature into the existing Flutter file hierarchy inside `lib/`.

## Complexity Tracking

| Violation | Why Needed | Simpler Alternative Rejected Because |
|-----------|------------|-------------------------------------|
| UI state modification | Spec demands string results | Displaying a numeric single result on the generic screen hides the secondary root; changing `currentInput` to `dynamic` or `String` breaks existing math without a wrapper object. |
