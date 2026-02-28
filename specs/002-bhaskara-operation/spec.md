# Feature Specification: Bhaskara Operation

**Feature Branch**: `002-bhaskara-operation`  
**Created**: 2026-02-27  
**Status**: Draft  
**Input**: User description: "um botão que calcula a fórmula completa de bhaskara"

## Clarifications

### Session 2026-02-27
- Q: Como o visor principal da calculadora deve mostrar as duas raízes calculadas? → A: Mostrar como texto: "[x1, x2]" no visor.
- Q: Como a calculadora deve reagir quando o discriminante (Delta) for negativo? → A: Exibir mensagem de erro: "Sem raízes reais".

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Calculating Real Roots (Priority: P1)

As a user, I want to click a button to calculate the Bhaskara formula so that I can easily find the roots of a quadratic equation (ax² + bx + c = 0) by providing the coefficients a, b, and c.

**Why this priority**: This is the core functionality requested by the user.

**Independent Test**: Can be fully tested by clicking the Bhaskara button, entering a=1, b=-3, c=2, and verifying the result is x1=2, x2=1.

**Acceptance Scenarios**:

1. **Given** the calculator is on the main screen, **When** I click the "Bhaskara" button, **Then** a modal/dialog or dedicated input area must appear asking for values of a, b, and c.
2. **Given** the Bhaskara input modal is open, **When** I enter a=1, b=-3, c=2 and press "Calculate", **Then** the results x1=2 and x2=1 should be displayed to the user.

---

### User Story 2 - Handling Complex Roots (Priority: P2)

As a user, I want the system to handle equations with no real roots gracefully so that I know the equation cannot be solved with real numbers instead of receiving an application error.

**Why this priority**: Essential to avoid crashes when dealing with negative discriminants ($\Delta < 0$).

**Independent Test**: Can be tested by entering coefficients where delta is negative, e.g., a=1, b=1, c=1.

**Acceptance Scenarios**:

1. **Given** the Bhaskara input modal is open, **When** I enter a=1, b=1, c=1 and press "Calculate", **Then** the system should display a message indicating "Sem raízes reais".

### Edge Cases

- What happens when a=0? The system should reject the input since it's not a valid quadratic equation.
- What happens when the user leaves a field blank? The system should require all three coefficients before allowing calculation.
- How are two results (x1, x2) displayed in the main calculator numerical display? The results will be shown as a formatted text string "[x1, x2]" directly on the main visor.

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: System MUST provide a dedicated "Bhaskara" button in the calculator interface.
- **FR-002**: System MUST capture three independent numerical inputs (coefficients a, b, and c) when the Bhaskara operation is triggered.
- **FR-003**: System MUST validate that the coefficient 'a' is not equal to zero.
- **FR-004**: System MUST calculate the discriminant (delta = b² - 4ac).
- **FR-005**: System MUST calculate up to two real roots using the standard formula.
- **FR-006**: System MUST handle cases where delta < 0 without crashing.

### Key Entities

- **Quadratic Equation**: Represents the mathematical inputs (a, b, c), the calculated discriminant, and the roots.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: 100% of quadratic equations with real roots yield the mathematically correct results.
- **SC-002**: Users can complete a Bhaskara calculation in under 15 seconds.
- **SC-003**: The app handles negative discriminant inputs without crashing 100% of the time.
