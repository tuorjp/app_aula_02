# Data Models: Extensible Calculator

## Entities

### `CalculatorState`
Represents the exact state of a calculation at any given moment, encapsulating everything an operation might need to know to perform its calculation.

**Fields**:
- `currentInput` (double): The numeric value currently being constructed/displayed.
- `accumulator` (double): The running total or left-hand operand stored so far.
- `lastOperator` (String?): The previous operator applied.
- `isNewInput` (boolean): Flag indicating if the next keypress should start a new input string (e.g. after pressing an operation).

**Immutability**:
In Flutter architecture, it's best practice for state objects to be immutable. Thus, methods should return a `copyWith()` mutation representing the *new* state.

### `Operation` (Interface/Abstract Class)
The contract that every single mathematical operation must follow.

**Fields**:
- `label` (String): The text to display on the calculator button (e.g., "+", "sin").

**Methods**:
- `CalculatorState execute(CalculatorState currentState)`: The core logic. Takes the immutable `currentState` and returns the newly computed `CalculatorState`.

---

## State Transitions (Example: Addition)

1. **Initial State**:
   - `accumulator`: 0
   - `currentInput`: 5
   - `lastOperator`: null
   - `isNewInput`: false
2. **Action**: User presses "+"
   - *Logic*: System looks up "+" in `OperationRegistry` and calls `execute`. 
   - *However*, traditional calculators don't execute "+" immediately against the empty accumulator. They stage it. 
   - A better modeling of the execute method for binary operators: 
     - Evaluate any pending `lastOperator`.
     - Set `currentOperator` to `this` operation.
     - Move `currentInput` -> `accumulator`. 
     - Return new State.
3. **Action**: User inputs "3" -> State updates `currentInput` to 3.
4. **Action**: User presses "="
   - *Logic*: System looks up `lastOperator` and calls its evaluation logic.
