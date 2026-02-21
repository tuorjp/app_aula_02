import 'package:flutter/material.dart';
import '../core/calculator_state.dart';
import '../core/operation.dart';
import '../core/operation_registry.dart';
import 'widgets/operation_button.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  CalculatorState _state = CalculatorState.initial();

  void _onNumberPressed(String numberStr) {
    setState(() {
      if (_state.isNewInput) {
        _state = _state.copyWith(
          currentInput: double.parse(numberStr),
          isNewInput: false,
        );
      } else {
        // Simple string concatenation for double
        final currentStr = _state.currentInput.toStringAsFixed(
          0,
        ); // Avoiding decimals for simplicity first
        final newStr = currentStr == '0' ? numberStr : '$currentStr$numberStr';
        _state = _state.copyWith(currentInput: double.parse(newStr));
      }
    });
  }

  void _onOperationPressed(Operation operation) {
    setState(() {
      // First evaluate any pending operation if applicable, otherwise just execute
      if (_state.lastOperator != null && !_state.isNewInput) {
        _evaluatePendingOperations();
      }
      _state = operation.execute(_state);
    });
  }

  void _evaluatePendingOperations() {
    if (_state.lastOperator == null) return;

    // Core binary evaluation based on previous operator
    double result = _state.currentInput;
    switch (_state.lastOperator) {
      case '+':
        result = _state.accumulator + _state.currentInput;
        break;
      case '-':
        result = _state.accumulator - _state.currentInput;
        break;
      case '*':
        result = _state.accumulator * _state.currentInput;
        break;
      case '/':
        if (_state.currentInput != 0) {
          result = _state.accumulator / _state.currentInput;
        } else {
          // Division by zero handler
          result = double.infinity;
        }
        break;
    }

    _state = _state.copyWith(
      currentInput: result,
      accumulator: result,
      clearLastOperator: true,
      isNewInput: true,
    );
  }

  void _onEqualsPressed() {
    setState(() {
      _evaluatePendingOperations();
    });
  }

  void _onClearPressed() {
    setState(() {
      _state = CalculatorState.initial();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Format output to drop '.0' if integer
    String displayText = _state.currentInput.toString();
    if (displayText.endsWith('.0')) {
      displayText = displayText.substring(0, displayText.length - 2);
    }
    if (displayText == 'Infinity') {
      displayText = 'Error';
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Extensible Calculator')),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.all(24),
              child: Text(
                displayText,
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                // Top controls grid placeholder
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: _onClearPressed,
                      child: const Text('C'),
                    ),
                    ElevatedButton(
                      onPressed: _onEqualsPressed,
                      child: const Text('='),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // Numbers
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    for (int i = 1; i <= 9; i++)
                      ElevatedButton(
                        onPressed: () => _onNumberPressed(i.toString()),
                        child: Text(i.toString()),
                      ),
                    ElevatedButton(
                      onPressed: () => _onNumberPressed('0'),
                      child: const Text('0'),
                    ),
                  ],
                ),
                const Spacer(),
                // Dynamic Operations Container
                const Divider(),
                const Text(
                  "Operations",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: OperationRegistry.instance.allOperations.map((
                      op,
                    ) {
                      return OperationButton(
                        operation: op,
                        onPressed: () => _onOperationPressed(op),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
