# Transactions

## Responsibility

Adds, edits, and deletes expenses and income entries, including categories, accounts, dates, notes, recurring flags, and receipt photos.

## Main files

- `features/transactions/service/transaction_service.dart`
- `features/transactions/service/transaction_balance_service.dart`
- `presentation/features/transactions/screen/add_transaction_screen.dart`
- `presentation/features/transactions/screen/transactions_screen.dart`

## Entry points

- UI: `AddTransactionScreen`, `TransactionsScreen`
- State: `transactionsProvider`
- Service: `TransactionService`, `TransactionBalanceService`

## Failure behavior

- Storage writes are isolated; a failed save does not stop the rest of the screen.
- Balance updates are applied separately from transaction storage so one can fail without breaking the other path.
- Delete operations fall back silently, leaving the UI to refresh from current store contents.

## Dependencies

- `HiveService`
- `CategoryService` for category info in list/detail displays
- `AccountService` for balance updates
- `BudgetRecheckService` for budget refresh after changes
