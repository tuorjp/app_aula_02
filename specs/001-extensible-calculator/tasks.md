---
description: "Task list for extensible simple calculator"
---

# Tasks: Extensible Simple Calculator

**Input**: Design documents from `/specs/001-extensible-calculator/`
**Prerequisites**: plan.md (required), spec.md (required), data-model.md, research.md

---

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Project initialization and basic structure

- [x] T001 Initialize the `core` folder structure (`lib/core/`).
- [x] T002 Initialize the `operations` folder structure (`lib/operations/`).
- [x] T003 Initialize the `ui/widgets` folder structure (`lib/ui/widgets/`).

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Core infrastructure that MUST be complete before ANY user story can be implemented

**⚠️ CRITICAL**: No user story work can begin until this phase is complete

- [x] T004 Create `CalculatorState` model in `lib/core/calculator_state.dart`.
- [x] [P] T005 Create `Operation` abstract class/interface in `lib/core/operation.dart`.
- [x] [P] T006 Create `OperationRegistry` singleton in `lib/core/operation_registry.dart`.
- [x] T007 Create basic `CalculatorScreen` shell in `lib/ui/calculator_screen.dart`.
- [x] T008 Update `lib/main.dart` to launch `CalculatorScreen`.

**Checkpoint**: Foundation ready - basic structure exists without operations.

---

## Phase 3: User Story 1 - Basic Calculator Operations (Priority: P1) 🎯 MVP

**Goal**: Users can perform standard simple calculations (addition, subtraction, multiplication, division).

**Independent Test**: Can be tested by verifying that entering numbers and pressing operation buttons yields the correct result.

### Implementation for User Story 1

- [x] [P] T009 [US1] Create `AddOperation` class in `lib/operations/add_operation.dart`.
- [x] [P] T010 [US1] Create `SubtractOperation` class in `lib/operations/subtract_operation.dart`.
- [x] [P] T011 [US1] Create `MultiplyOperation` class in `lib/operations/multiply_operation.dart`.
- [x] [P] T012 [US1] Create `DivideOperation` class in `lib/operations/divide_operation.dart`.
- [x] T013 [US1] Create numerical and function evaluation keys (e.g. "=") logic inside `CalculatorScreen` or a separate input handler in `lib/ui/calculator_screen.dart`.
- [x] T014 [US1] Register `AddOperation`, `SubtractOperation`, `MultiplyOperation`, and `DivideOperation` in `lib/main.dart` or an initializer.

**Checkpoint**: At this point, basic calculator operations are fully functional.

---

## Phase 4: User Story 2 - Dynamic Operation Discovery (Priority: P1)

**Goal**: Developers can add new operations without modifying the UI components. The system dynamically discovers and renders available operations.

**Independent Test**: Can be tested by adding a dummy operation class and verifying it appears in the UI and functions correctly without UI code changes.

### Implementation for User Story 2

- [x] [P] T015 [US2] Create `OperationButton` widget in `lib/ui/widgets/operation_button.dart` to represent a single dynamic operation.
- [x] T016 [US2] Update `CalculatorScreen` in `lib/ui/calculator_screen.dart` to read from `OperationRegistry` and generate `OperationButton`s dynamically.

**Checkpoint**: The UI now strictly decouples operation rendering from operation definitions.

---

## Phase 5: Polish & Cross-Cutting Concerns

**Purpose**: Improvements that affect multiple user stories

- [x] T017 Implement basic error handling for operations (e.g., division by zero) updating `CalculatorState` appropriately.
- [x] T018 Code cleanup and verify `flutter analyze` passes zero warnings.
- [x] [P] T019 Run unit tests / verification steps manually via `flutter test` (if tests were added) and verify app manually.

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: Can start immediately.
- **Foundational (Phase 2)**: Depends on Phase 1. Blocks all user stories.
- **User Stories (Phase 3 & 4)**: 
  - User Story 1 (Basic Operations) depends on Foundational objects.
  - User Story 2 (Dynamic Discovery) can be implemented alongside or slightly after US1.
- **Polish (Final Phase)**: Depends on all user stories being complete.

### Parallel Opportunities

- Creating folders in Phase 1 setup.
- `Operation` and `OperationRegistry` can be created simultaneously in Phase 2.
- The four basic arithmetic operations (`AddOperation`, `SubtractOperation`, etc.) in Phase 3 can all be implemented in parallel.
- Creating the `OperationButton` widget isolated in Phase 4 is independent of the mathematical logic of Phase 3.

## Implementation Strategy

### MVP First

1. Complete Setup & Foundational Phases.
2. Complete US1 (Basic Operations) & US2 (Dynamic UI Rendering) to fulfill the decoupled requirement together.
3. Validate by adding a test operation.
