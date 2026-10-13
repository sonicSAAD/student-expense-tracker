# Budgets

## Responsibility

Tracks monthly category budget limits and spent amounts, and shows month overview stats and per-category progress.

## Main files

- `features/budgets/service/budget_service.dart`
- `features/budgets/service/budget_recheck_service.dart`
- `presentation/features/budgets/screen/budgets_screen.dart`

## Entry points

- UI: `BudgetsScreen`
- State: `currentMonthBudgetsProvider`, `monthIncomeProvider`, `monthExpenseProvider`, `categorySpendingProvider`
- Service: `BudgetService`, `BudgetRecheckService`

## Failure behavior

- Spending calculations are computed from transactions defensively and return zero/empty on error.
- Budget save/update operations degrade gracefully if Hive access fails.
- Budget rechecks are isolated so a problem in one category/month does not stop other rechecks.

## Dependencies

- `HiveService`
- `TransactionService`
- `CategoryService`
- `BudgetRecheckService` coordinates with transaction and category services
