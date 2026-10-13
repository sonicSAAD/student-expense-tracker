# Recurring Bills

## Responsibility

Manages recurring bills, reminders, and mark-as-paid flows that create a transaction and schedule the next occurrence.

## Main files

- `features/recurring_bills/service/recurring_bill_service.dart`
- `features/recurring_bills/service/recurring_bill_paid_service.dart`
- `presentation/features/recurring_bills/screen/recurring_bills_screen.dart`

## Entry points

- UI: `RecurringBillsScreen`
- State: `recurringBillsProvider`
- Service: `RecurringBillService`, `RecurringBillPaidService`

## Failure behavior

- Reminder scheduling and cancellation are isolated from storage writes where possible.
- Mark-as-paid creates a transaction and updates the bill through isolated steps; one step failing does not block the other from being attempted independently.
- Missing account/category fallbacks prevent crashes during paid actions.

## Dependencies

- `HiveService`
- `NotificationService`
- `TransactionService`
- `AccountService`
- `RecurringBillService`
