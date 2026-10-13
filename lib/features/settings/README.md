# Settings

## Responsibility

Manages app preferences, theme, notifications, security lock settings, and data actions such as export/import and onboarding reset.

## Main files

- `features/settings/service/settings_service.dart`
- `presentation/features/settings/screen/settings_screen.dart`

## Entry points

- UI: `SettingsScreen`, `AppLockGate`
- State: `settingsProvider`
- Service: `SettingsService`

## Failure behavior

- Settings reads return a safe default if storage is unavailable.
- Saves are best-effort; the UI continues working even if a write fails.
- Lock checks and biometric actions are isolated so auth failure does not crash the app shell.

## Dependencies

- `HiveService`
- `local_auth` for biometric unlock
- `BackupService` for export/import actions
