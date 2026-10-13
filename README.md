# Student Expense Tracker

A modular, offline-first Flutter app for tracking expenses, budgets, recurring bills, savings goals, accounts, and split expenses.

The UI is intentionally minimalist and monochrome. Hierarchy comes from spacing, typography weight, borders, and icons rather than color.

## Project map

```text
lib/
├── main.dart
├── app.dart
├── core/
│   ├── constants/
│   ├── services/
│   ├── theme/
│   └── utils/
├── data/
│   ├── mappers/
│   └── repositories/        # legacy compatibility kept minimal
├── domain/
│   ├── entities/
│   └── usecases/
├── features/
│   ├── accounts/
│   ├── transactions/
│   ├── budgets/
│   ├── categories/
│   ├── analytics/
│   ├── recurring_bills/
│   ├── savings_goals/
│   ├── split_expenses/
│   ├── settings/
│   └── backup/
└── presentation/
    ├── providers/
    ├── router/
    ├── screens/
    ├── features/
    └── widgets/
```

## Feature folders

Each feature owns its service layer, screen, and routing namespace:

- `features/accounts/` — wallets and transfers
- `features/transactions/` — expenses and income entries
- `features/budgets/` — category limits and month spend
- `features/categories/` — category definitions
- `features/analytics/` — charts and exports
- `features/recurring_bills/` — subscriptions and bill reminders
- `features/savings_goals/` — savings targets
- `features/split_expenses/` — shared cost splitting
- `features/settings/` — preferences, security, data actions
- `features/backup/` — export/import backup

Shared UI pieces live in `presentation/widgets/`. Shared state wiring lives in `presentation/providers/app_providers.dart`.

## Design principles

- **Modular by feature:** each feature can be read, modified, or removed with limited blast radius.
- **Independent operations:** service methods catch their own storage/IO failures and degrade gracefully instead of crashing a screen.
- **Small files:** most source files are sized for one clear responsibility; large old files were split into focused helpers.
- **Neutral UI:** black, white, and gray tones with minimal accent use for focus states only.

## Getting started

```bash
flutter pub get
flutter run
```

## Tests

```bash
flutter test
```

## Docs

- Root README: this file.
- Feature docs: each `features/*/README.md` explains that feature's responsibility, main files, entry points, and failure behavior.
- Core docs: `core/README.md` explains shared services, theme, and utilities.

## Architecture notes

State is provided through Riverpod. Storage uses Hive. Navigation uses `go_router`.

Feature services are intentionally independent:

- transaction service
- account service
- category service
- budget service
- recurring bill service
- savings goal service
- split expense service
- settings service
- backup service

Higher-level helpers such as transfers, balance updates, budget rechecks, and mark-as-paid flows compose those services without forcing one giant repository.

## Branding

App icon and logo artifacts are stored in `assets/icon/`. Android and iOS launcher icon sets are generated from the same source mark.

## License

This project is **private and restrictive**.

You may view it and take inspiration from it, but you may not copy it or reuse it in other projects.

Copyright (c) 2026 Mohammad Saad https://github.com/sonicSAAD

See `LICENSE` for the full terms.

## Author

Mohammad Saad
https://github.com/sonicSAAD

## Releases

This repository uses GitHub Actions to build and release application artifacts from version tags.

The workflow lives in `.github/workflows/release.yml`. It runs on tagged releases and on manual dispatch, analyzes the code, and builds the Android release artifacts for publication.

Repository: https://github.com/sonicSAAD/student-expense-tracker
