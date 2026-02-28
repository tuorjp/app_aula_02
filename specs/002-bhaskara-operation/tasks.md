# Tasks: Bhaskara Operation

**Input**: Design documents from `/specs/002-bhaskara-operation/`
**Prerequisites**: plan.md (required), spec.md (required for user stories), research.md, data-model.md, contracts/

**Organization**: Tasks are grouped by user story to enable independent implementation and testing of each story.

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Can run in parallel (different files, no dependencies)
- **[Story]**: Which user story this task belongs to (e.g., US1, US2, US3)
- Include exact file paths in descriptions

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Project initialization and basic structure

- [ ] T001 Create basic empty structure for `lib/operations/bhaskara_operation.dart`
- [ ] T002 Create basic empty structure for `lib/ui/widgets/bhaskara_input_modal.dart`

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Core infrastructure that MUST be complete before ANY user story can be implemented

**⚠️ CRITICAL**: No user story work can begin until this phase is complete

- [ ] T003 Update `CalculatorState` in `lib/core/calculator_state.dart` to add `final String? displayOverride;` and update constructor/copyWith.
- [ ] T004 Update `build` method in `lib/ui/calculator_screen.dart` to render `_state.displayOverride` if it is not null, bypassing the default double formatting.

**Checkpoint**: Foundation ready - user story implementation can now begin in parallel

---

## Phase 3: User Story 1 - Calculating Real Roots (Priority: P1) 🎯 MVP

**Goal**: As a user, I want to click a button to calculate the Bhaskara formula so that I can easily find the roots of a quadratic equation (ax² + bx + c = 0) by providing the coefficients a, b, and c.

**Independent Test**: Can be fully tested by clicking the Bhaskara button, entering a=1, b=-3, c=2, and verifying the result is x1=2, x2=1.

### Implementation for User Story 1

- [ ] T005 [P] [US1] Implement `BhaskaraInputModal` in `lib/ui/widgets/bhaskara_input_modal.dart` to collect text inputs for `a`, `b`, and `c` and return them as a tuple or custom class.
- [ ] T006 [P] [US1] Implement `BhaskaraOperation` in `lib/operations/bhaskara_operation.dart` to accept coefficients, compute the roots, and output `displayOverride = "[x1, x2]"`.
- [ ] T007 [US1] Update `CalculatorScreen` logic in `lib/ui/calculator_screen.dart` to intercept the operation press if it's Bhaskara, show the modal, and then apply `BhaskaraOperation` with the collected inputs.
- [ ] T008 [US1] Register the button generically in `lib/main.dart` under `OperationRegistry` (or handle it directly if treating it as a special meta-operation).

**Checkpoint**: At this point, User Story 1 should be fully functional and testable independently

---

## Phase 4: User Story 2 - Handling Complex Roots (Priority: P2)

**Goal**: As a user, I want the system to handle equations with no real roots gracefully so that I know the equation cannot be solved with real numbers instead of receiving an application error.

**Independent Test**: Can be tested by entering coefficients where delta is negative, e.g., a=1, b=1, c=1.

### Implementation for User Story 2

- [ ] T009 [US2] Update `BhaskaraOperation` in `lib/operations/bhaskara_operation.dart` to check for $\Delta < 0$ and set `displayOverride = "Sem raízes reais"`.
- [ ] T010 [US2] Update `BhaskaraOperation` in `lib/operations/bhaskara_operation.dart` to handle $a=0$ gracefully, perhaps setting `displayOverride = "Erro: a=0"`.

**Checkpoint**: At this point, User Stories 1 AND 2 should both work independently

---

## Phase 5: Polish & Cross-Cutting Concerns

**Purpose**: Improvements that affect multiple user stories

- [ ] T011 Run `flutter analyze` to ensure zero warnings (Constitution Principle III).
- [ ] T012 Manual UI checking to verify dynamic layout sizing with long strings like "Sem raízes reais" on smaller screens.

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: No dependencies - can start immediately
- **Foundational (Phase 2)**: Depends on Setup completion - BLOCKS all user stories
- **User Stories (Phase 3+)**: All depend on Foundational phase completion
  - Sequential in priority order (P1 → P2)
- **Polish (Final Phase)**: Depends on all desired user stories being complete

### Parallel Opportunities

- Foundational updates to `CalculatorState` and `CalculatorScreen` could be done sequentially quickly.
- [P] T005 and T006 can be run completely in parallel, as the UI modal and the Calculation logic are independent. 

## Implementation Strategy

### MVP First (User Story 1 Only)

1. Complete Phase 1: Setup
2. Complete Phase 2: Foundational (CRITICAL)
3. Complete Phase 3: User Story 1
4. **STOP and VALIDATE**: Test User Story 1 independently.

### Incremental Delivery

1. Complete Setup + Foundational -> Foundation ready
2. Add User Story 1 -> Test independently -> Deploy/Demo (MVP)
3. Add User Story 2 -> Test independently -> Deploy/Demo
