# Quickstart: Extensible Calculator

This document explains how to set up the project and run it for the first time.

## Prerequisites
- Flutter SDK 3.11+
- Dart 3.11+

## Running the Application
```bash
# Get dependencies
flutter pub get

# Run the app locally (windows/web/mobile emulator)
flutter run
```

## Adding a New Operation
The calculator is designed to be fully extensible without modifying the UI (`calculator_screen.dart`).

1. Create a new file in `lib/operations/` (e.g. `power_operation.dart`).
2. Create a class implementing the `Operation` interface:
   ```dart
   import '../core/operation.dart';
   import '../core/calculator_state.dart';

   class PowerOperation extends Operation {
     @override
     String get label => '^';

     @override
     CalculatorState execute(CalculatorState state) {
       // Implement evaluation logic
       // E.g., apply pending operations, square the input, and return new state
     }
   }
   ```
3. Register the operation in `lib/main.dart` or during app initialization:
   ```dart
   OperationRegistry.instance.register(PowerOperation());
   ```
4. Build and run. The UI will automatically generate a button labeled `^` in the grid.
