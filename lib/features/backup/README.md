# Backup

## Responsibility

Exports app data as JSON, imports it back, and shares the backup file.

## Main files

- `features/backup/service/backup_service.dart`

## Entry points

- Service: `BackupService`

## Failure behavior

- Export returns a safe structure even if some boxes fail; it does not throw through the UI.
- Import clears and restores each box independently so one bad box does not block the others.
- Share/write failures are caught and ignored at the UI boundary.

## Dependencies

- `HiveService`
- `share_plus`
- `path_provider`
