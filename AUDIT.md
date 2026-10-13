# Project Audit Report — Student Expense Tracker

## Scope
- 39 Dart source files under `lib/`
- Focus: modularity, per-file size, function independence/fault isolation, UI aesthetics, documentation

## 1) Architecture
- Split across `core/`, `data/`, `domain/`, `presentation/`
- State: Riverpod
- Storage: Hive
- Navigation: go_router
- Strong points: separation of entities/repos/theme/services exists

## 2) File-size findings
Large files (well over 65 LOC):
- `lib/data/repositories/expense_repository.dart` — 474 LOC
- `lib/presentation/screens/settings/settings_screen.dart` — 405 LOC
- `lib/presentation/screens/home/dashboard_screen.dart` — 388 LOC
- `lib/presentation/screens/analytics/analytics_screen.dart` — 376 LOC
- `lib/presentation/screens/transactions/add_transaction_screen.dart` — 327 LOC
- `lib/presentation/screens/transactions/transactions_screen.dart` — 292 LOC
- `lib/presentation/screens/goals/savings_goals_screen.dart` — 261 LOC
- `lib/presentation/screens/onboarding/onboarding_screen.dart` — 258 LOC
- `lib/presentation/screens/bills/recurring_bills_screen.dart` — 245 LOC
- `lib/presentation/screens/split/split_expenses_screen.dart` — 202 LOC
- `lib/presentation/screens/accounts/accounts_screen.dart` — 197 LOC
- `lib/data/mappers/entity_mappers.dart` — 183 LOC
- `lib/presentation/router/app_router.dart` — 115 LOC
- `lib/core/theme/app_theme.dart` — 117 LOC
- `lib/core/services/hive_service.dart` — 114 LOC
- `lib/presentation/providers/app_providers.dart` — 100 LOC
- `lib/core/services/backup_service.dart` — 91 LOC
- `lib/core/services/notification_service.dart` — 92 LOC

Many files already small. Several domain entities are fine as-is.

## 3) Modularity
- Repositories and screens are feature-heavy and mix concerns.
- `expense_repository.dart` is a god object: transactions, accounts, budgets, recurring bills, savings goals, splits, transfers, notifications.
- Screens often embed dialogs, filter UI, export logic, calculations, and navigation in one widget.
- Mappers are centralized but huge.

## 4) Function independence / fault isolation
- Weak. Many operations chain multiple side effects in one async method (storage + balance update + budget recalculation + notifications).
- One failure can leave related state out of sync because error handling is minimal and fallbacks are rare.
- Settings/theme/lock logic intertwined with UI dialogs.

## 5) UI aesthetics
- Current theme is colorful (teal/blue/accents, gradients, category colors).
- Not minimalist black-and-white.
- Rounded cards, colored indicators, celebration colors present.

## 6) Documentation
- Root README exists and is good.
- No per-feature READMEs.
- Little inline ownership/boundary documentation.

## 7) Recommended restructure
- Feature-oriented folders:
  - `features/accounts/`
  - `features/transactions/`
  - `features/budgets/`
  - `features/analytics/`
  - `features/recurring_bills/`
  - `features/savings_goals/`
  - `features/split_expenses/`
  - `features/settings/`
  - `features/onboarding/`
  - `features/shell/`
  - `core/` kept for truly shared minimal utilities
- Each feature folder:
  - `api/` or `service/` for independent operations with fallbacks
  - `model/` or `entity/` when feature-specific
  - `screen/`, `widgets/`, `providers/` as needed
  - `README.md` for that feature
- Keep each file near or under 65 LOC by splitting:
  - repositories by entity/feature
  - providers by feature
  - screens into screen + widgets + dialogs + helpers
  - theme into monochromatic tokens
- Independence strategy:
  - one operation per async function where practical
  - each feature service catches its own errors and returns graceful fallbacks
  - avoid cross-feature transactional coupling in UI layer

## 8) Black-and-white UI direction
- Use monochrome tokens: blacks, whites, grays, one optional subtle accent for focus states only.
- Remove gradient backgrounds, category colors, celebration colors.
- Use borders, typography weight, spacing, and icons for hierarchy.
- Keep Material 3 structure but with neutral color scheme.

## 9) Documentation plan
- Root `README.md`: overview, architecture, feature map, setup, run tests.
- Per-feature `README.md`: responsibility, key files, entry points, failure behavior, dependencies.
- Keep function-level docs minimal and practical (purpose, inputs, fallbacks).

## 10) Suggested execution order
1. Establish new modular folder layout.
2. Rewrite theme as monochrome.
3. Split repository into per-feature services with independent error handling.
4. Split large screens into small files.
5. Add per-feature READMEs and update root README.
6. Run analyzer and tests to verify.
