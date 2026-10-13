# Analytics

## Responsibility

Shows category spending, six-month trends, income vs expense charts, top categories, and exports data as CSV or PDF.

## Main files

- `presentation/features/analytics/screen/analytics_screen.dart`

## Entry points

- UI: `AnalyticsScreen`
- State: `transactionsProvider`, `categoriesProvider`, `categorySpendingProvider`, `monthIncomeProvider`, `monthExpenseProvider`

## Failure behavior

- Export actions are isolated UI actions; if sharing or PDF generation fails, the screen remains usable.
- Chart data is computed from providers; missing data results in empty states rather than crashes.

## Dependencies

- `BudgetService` for monthly income/expense totals
- `CategoryService` and `TransactionService` data through providers
- `share_plus`, `csv`, `pdf`, `printing` for exports
