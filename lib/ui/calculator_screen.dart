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
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // Display Area
            Expanded(
              flex: 2,
              child: Container(
                alignment: Alignment.bottomRight,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 32,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if (_state.lastOperator != null)
                      Text(
                        '${_state.accumulator.toString().replaceAll('.0', '')} ${_state.lastOperator}',
                        style: TextStyle(fontSize: 24, color: Colors.grey[600]),
                      ),
                    Text(
                      displayText,
                      style: const TextStyle(
                        fontSize: 72,
                        fontWeight: FontWeight.w300,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Buttons Area
            Expanded(
              flex: 5,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey[900]!.withOpacity(0.5),
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(32),
                  ),
                ),
                child: Column(
                  children: [
                    // SECTION 1: NUMBERS & BASIC CONTROLS (TOP)
                    Row(
                      children: [
                        _buildNumButton('7'),
                        _buildNumButton('8'),
                        _buildNumButton('9'),
                        OperationButton(
                          label: 'C',
                          onPressed: _onClearPressed,
                          backgroundColor: Colors.grey[400],
                          textColor: Colors.black,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        _buildNumButton('4'),
                        _buildNumButton('5'),
                        _buildNumButton('6'),
                        _buildNumButton('.'),
                      ],
                    ),
                    Row(
                      children: [
                        _buildNumButton('1'),
                        _buildNumButton('2'),
                        _buildNumButton('3'),
                        _buildNumButton('0'),
                      ],
                    ),

                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Divider(
                        color: Colors.white24,
                        indent: 12,
                        endIndent: 12,
                      ),
                    ),

                    // SECTION 2: ARITHMETIC OPERATIONS (MIDDLE)
                    Row(
                      children: [
                        _buildRegistryOp('+'),
                        _buildRegistryOp('-'),
                        _buildRegistryOp('*'),
                        _buildRegistryOp('/'),
                      ],
                    ),

                    // SECTION 3: EVALUATION (BOTTOM)
                    Row(
                      children: [
                        OperationButton(
                          label: '=',
                          onPressed: _onEqualsPressed,
                          backgroundColor: Colors.orange[800],
                        ),
                      ],
                    ),

                    // Extra dynamic operations
                    if (_getExtraOperations().isNotEmpty) ...[
                      const Divider(color: Colors.white24, height: 20),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Wrap(
                            alignment: WrapAlignment.start,
                            children: _getExtraOperations().map((op) {
                              return Container(
                                width:
                                    (MediaQuery.of(context).size.width - 24) /
                                    4,
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: ElevatedButton(
                                    onPressed: () => _onOperationPressed(op),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blueGrey[800],
                                      foregroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 20,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                    child: Text(
                                      op.label,
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNumButton(String num, {bool isLarge = false}) {
    return OperationButton(
      label: num,
      onPressed: () => _onNumberPressed(num),
      backgroundColor: Colors.grey[850],
      isLarge: isLarge,
    );
  }

  Widget _buildRegistryOp(String symbol) {
    try {
      final op = OperationRegistry.instance.allOperations.firstWhere(
        (o) => o.label == symbol,
      );
      return OperationButton(
        label: op.label,
        onPressed: () => _onOperationPressed(op),
        backgroundColor: Colors.orange[800],
      );
    } catch (e) {
      return const Expanded(child: SizedBox());
    }
  }

  List<Operation> _getExtraOperations() {
    const primaryOps = ['+', '-', '*', '/'];
    return OperationRegistry.instance.allOperations
        .where((op) => !primaryOps.contains(op.label))
        .toList();
  }
}
