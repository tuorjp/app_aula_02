<!--
SYNC IMPACT REPORT
Version: Initial Draft -> 1.0.0

Modified Principles:
- [PRINCIPLE_1_NAME] -> I. Composition Over Monoliths
- [PRINCIPLE_2_NAME] -> II. Predictable State Management
- [PRINCIPLE_3_NAME] -> III. Strict Type Safety & Analysis
- [PRINCIPLE_4_NAME] -> Removed
- [PRINCIPLE_5_NAME] -> Removed

Added Sections:
- Architecture Constraints
- Development Workflow

Removed Sections: None

Templates requiring updates:
- .specify/templates/plan-template.md (✅ updated)
- .specify/templates/spec-template.md (✅ checked, no update needed)
- .specify/templates/tasks-template.md (✅ checked, no update needed)
-->

# app_aula_02 Constitution

## Core Principles

### I. Composition Over Monoliths
Build UIs by composing small, focused widgets rather than large monolithic widgets. Use `const` constructors wherever possible to improve rendering performance.

### II. Predictable State Management
Favor simple local state using `StatefulWidget` for isolated UI state. For global or cross-widget state, ensure a clear, unidirectional data flow that separates business logic from UI.

### III. Strict Type Safety & Analysis
Ensure strongly-typed code in all Dart files. Maintain strict linting rules and require zero warnings or errors from `flutter analyze` for any code merged into the main branch.

## Architecture Constraints

Ensure clear separation of concerns. Do not mix UI code directly with business logic or network calls. Follow a cohesive directory structure (e.g., separating models, views, and viewmodels/controllers). Use dependency injection or service locators to provide dependencies rather than hardcoding instantiations.

## Development Workflow

Before creating a pull request, all developers MUST manually run `flutter analyze` and `flutter test`. 
Code reviews must ensure that UI compositions remain small and maintainable. Breaking changes should be discussed prior to implementation.

## Governance

The Constitution supersedes all other practices. All PRs and code reviews must verify compliance with the Core Principles. Amendments to this document require documentation of the rationale and team agreement.

**Version**: 1.0.0 | **Ratified**: 2026-02-20 | **Last Amended**: 2026-02-20
