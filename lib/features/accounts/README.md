# Accounts

## Responsibility

Manages wallets/accounts: list, add, edit, delete, transfer, and total balance.

## Main files

- `features/accounts/service/account_service.dart`
- `features/accounts/service/transfer_service.dart`
- `presentation/features/accounts/screen/accounts_screen.dart`

## Entry points

- UI: `AccountsScreen`
- State: `accountsProvider`, `totalBalanceProvider`
- Service: `AccountService`, `TransferService`

## Failure behavior

- Storage reads fall back to empty lists or null account instead of throwing through the UI.
- Transfers validate IDs and amounts before mutating anything and will no-op on invalid input.
- Balance updates and transfers are performed through isolated helpers so one failure does not block other unrelated account actions.

## Dependencies

- `HiveService`
- `TransactionService` for transfer record entries
- `AccountService` for balance reads/writes
