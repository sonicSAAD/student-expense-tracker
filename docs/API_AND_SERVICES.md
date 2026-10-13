# API, Services & State Reference

This document provides a reference for the core services, domain calculators, entities, and Riverpod state management providers.

---

## 1. Feature Services (`lib/features/`)

All services are registered within `AppFeatureServices` (`lib/presentation/providers/app_feature_services.dart`):

| Service | Responsibility | Key Methods |
|---|---|---|
| `AccountService` | Account storage & balance tracking | `getAll()`, `findById()`, `add()`, `update()`, `delete()`, `getTotalBalance()` |
| `TransferService` | Inter-account fund transfers | `transfer({fromId, toId, amount, note})` |
| `TransactionService` | Transaction logging | `getAll()`, `findById()`, `add()`, `update()`, `delete()` |
| `TransactionBalanceService` | Account balance adjustment on transaction events | `apply(transaction, {isNew, isDelete})`, `revert(transaction)` |
| `BudgetService` | Monthly category spending & limits | `getForMonth()`, `setLimit()`, `spentForCategory()`, `monthIncome()`, `monthExpense()` |
| `BudgetRecheckService` | Recalculate and update budget limits | `recheckAfterTransaction()`, `recheckAll()` |
| `CategoryService` | Category management | `getAll()`, `findById()`, `add()`, `update()`, `delete()` |
| `RecurringBillService` | Recurring bill definitions | `getAll()`, `findById()`, `add()`, `update()`, `delete()` |
| `RecurringBillPaidService` | Mark bill as paid & advance due date | `markAsPaid(bill)`, `markPaid(bill)` |
| `SavingsGoalService` | Savings goals & contributions | `getAll()`, `add()`, `update()`, `delete()`, `addMoney()` |
| `SplitExpenseService` | Group shared expense settlement | `getAll()`, `add()`, `update()`, `delete()`, `markParticipantPaid()` |
| `SettingsService` | User preferences & security | `get()`, `update()`, `reset()` |
| `BackupService` | Database export & system share | `exportAll()`, `importData()`, `shareBackup()` |

---

## 2. Pure Domain Calculators (`lib/domain/usecases/`)

Pure computational use cases without side effects:

- **`BudgetCalculator`**:
  - `spentPercentage(spent, limit)`: Computes percentage clamped to `0.0` - `100.0`.
  - `isOverBudget(spent, limit)`: Returns `true` if spending exceeds the limit.
  - `isNearBudget(spent, limit, threshold = 0.8)`: Returns `true` if spend is within threshold.
  - `remainingBudget(spent, limit)`: Computes remaining allowance.
- **`RecurringBillCalculator`**:
  - `nextMonthlyDueDate(currentDueDate)`: Calculates future monthly cycle date.
  - `nextWeeklyDueDate(currentDueDate)`: Calculates 7-day advance date.
  - `reminderDate(dueDate, daysBefore)`: Computes local notification trigger timestamp.
  - `isDueSoon(dueDate, daysThreshold = 3)`: Flags urgent upcoming bills.
- **`SplitCalculator`**:
  - `splitEqually(totalAmount, participantCount)`: Computes equal splits.
  - `isFullySettled(paidStatuses)`: Checks whether all members have cleared debts.
  - `totalOwed(amounts, paidStatuses)`: Sums outstanding owed balance.

---

## 3. Riverpod Providers (`lib/presentation/providers/`)

Scoped providers providing reactive state across the application:

- **Infrastructure**:
  - `hiveServiceProvider`: Singleton access to `HiveService`.
  - `notificationServiceProvider`: Singleton access to `NotificationService`.
  - `appFeatureProvider`: Aggregated service bundle (`AppFeatureServices`).
  - `appRefreshProvider`: Signal state notifier to force global UI refreshes.
- **Data Collections**:
  - `transactionsProvider`: Current transaction records.
  - `categoriesProvider`: Configured expense/income categories.
  - `accountsProvider`: Available bank and cash accounts.
  - `settingsProvider`: Reactive `AppSettings` (currency, theme mode, lock state).
  - `recurringBillsProvider`: Active bills and subscriptions.
  - `savingsGoalsProvider`: Active savings goals.
  - `splitExpensesProvider`: Shared split expense records.
- **Computed Metrics**:
  - `totalBalanceProvider`: Sum of all account balances.
  - `currentMonthBudgetsProvider`: Budgets for the active month.
  - `categorySpendingProvider`: Map of category ID to monthly spend.
  - `monthIncomeProvider` & `monthExpenseProvider`: Aggregated monthly totals.
