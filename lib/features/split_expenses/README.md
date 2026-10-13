# Split Expenses

## Responsibility

Tracks shared expenses, participant splits, payment status, and settlement state.

## Main files

- `features/split_expenses/service/split_expense_service.dart`
- `presentation/features/split_expenses/screen/split_expenses_screen.dart`

## Entry points

- UI: `SplitExpensesScreen`
- State: `splitExpensesProvider`
- Service: `SplitExpenseService`

## Failure behavior

- Reads return empty lists on storage issues.
- Participant checks and settlement updates are done defensively.
- Updates and deletes are best-effort storage operations.

## Dependencies

- `HiveService`
- `SplitCalculator` for split logic
