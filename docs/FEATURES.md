# Feature Guide & Capabilities

Student Expense Tracker provides an end-to-end suite of personal financial tools tailored for students.

---

## 1. Dashboard & Home (`lib/presentation/features/home/`)
- **Total Balance Overview**: Aggregate financial balance calculated in real time across all linked accounts.
- **Monthly Summary Cards**: Income vs. Expense metrics for the active calendar month.
- **Budget Tracking Widget**: Progress bars highlighting current monthly category limits.
- **Upcoming Bills**: Glanceable view of pending recurring bills.
- **Recent Activity**: Quick chronological listing of the latest transactions.

---

## 2. Transactions & Search (`lib/presentation/features/transactions/`)
- **Income & Expense Logging**: Fast transaction entry with amount, category, account, and date.
- **Search & Filtering**: Search by transaction notes, filter by type (Income vs Expense), and group transactions chronologically.
- **Automatic Balance Synchronization**: Adding, modifying, or removing a transaction automatically adjusts associated account balances.

---

## 3. Budgets (`lib/presentation/features/budgets/`)
- **Category Monthly Limits**: Set specific spending limits for categories (e.g., Food, Books, Rent, Entertainment).
- **Overspending Alerts**: Visual warnings when spending approaches or exceeds 80% and 100% of limits.
- **Dynamic Calculation**: Real-time spending recalculation upon any transaction updates.

---

## 4. Accounts & Transfers (`lib/presentation/features/accounts/`)
- **Multi-Account Support**: Manage Cash, Bank, Digital Wallets, and Savings accounts.
- **Inter-Account Transfers**: Atomic balance transfers between accounts with accompanying transaction records.

---

## 5. Recurring Bills & Subscriptions (`lib/presentation/features/recurring_bills/`)
- **Bill Cycles**: Support for Weekly and Monthly recurring obligations.
- **Mark as Paid**: One-tap payment tracking that generates the corresponding expense transaction and automatically advances the next due date.
- **Local Notifications**: Scheduled notifications via `flutter_local_notifications` and `timezone` to notify users before due dates.

---

## 6. Savings Goals (`lib/presentation/features/savings_goals/`)
- **Target Tracking**: Define goal names, target amounts, and deadlines.
- **Contribution Log**: Add funds incrementally towards goals with visual progress bars.

---

## 7. Split Expenses (`lib/presentation/features/split_expenses/`)
- **Group Expense Splitting**: Divide restaurant bills, shared apartment rent, or group project costs evenly among participants.
- **Settlement Tracking**: Check off individual participants when paid, auto-settling when all debts are cleared.

---

## 8. Analytics & Reporting (`lib/presentation/features/analytics/`)
- **Spending Visualizations**: Interactive bar charts and category distribution breakdowns using `fl_chart`.
- **CSV Data Export**: Export detailed transaction logs as standardized CSV files.
- **PDF Financial Report**: Generate and print formatted PDF reports using `pdf` and `printing`.

---

## 9. Security & Privacy (`lib/presentation/features/settings/`)
- **PIN Lock Gate**: Secure app lock requiring a 4-digit PIN upon startup.
- **Biometric Unlock**: Fingerprint and Face Unlock support powered by `local_auth`.

---

## 10. Backup & Offline Data (`lib/presentation/features/settings/`, `lib/features/backup/`)
- **Zero Cloud Requirement**: 100% local offline storage using encrypted and lightning-fast Hive boxes.
- **JSON Backup & Share**: Export complete snapshot files and restore preferences seamlessly.
