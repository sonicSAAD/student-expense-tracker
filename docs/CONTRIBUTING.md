# Contributing & Engineering Standards

Thank you for contributing to **Student Expense Tracker**. Please review the following standards and workflow rules before submitting modifications.

---

## 1. The Strict 65 LOC Rule

Every `.dart` file under `lib/` and `test/` **must strictly contain 65 lines of code or fewer**.

### Rules for Compliance:
- **Single Responsibility**: Each file must address exactly one concern.
- **Decomposition**: Extract complex widgets into dedicated sub-widgets in `widgets/` or `screen/`.
- **Pure Helpers**: Factor calculation algorithms into pure domain functions in `lib/domain/usecases/`.
- **Mappers**: Do not write in-line mapping logic in entity or service files; place them in `lib/data/mappers/`.

### Automated Verification:
You can verify compliance before committing by running:
```powershell
Get-ChildItem -Recurse -File -Include *.dart -Path lib,test | ForEach-Object {
    $lines = (Get-Content $_.FullName | Measure-Object -Line).Lines
    if ($lines -gt 65) {
        Write-Error "$($_.FullName): $lines lines (exceeds 65 limit)"
    }
}
```

---

## 2. Code Quality & Formatting

Before opening a pull request or pushing:

```bash
# 1. Fetch dependencies
flutter pub get

# 2. Run static analysis (must report zero errors, warnings, or infos)
flutter analyze

# 3. Run all unit and widget tests (all tests must pass)
flutter test
```

---

## 3. Architecture Conventions

- **State Management**: Use `flutter_riverpod` providers. Avoid stateful monolithic classes.
- **Persistence**: Leverage `HiveService`. Do not invoke raw disk I/O directly in UI widgets.
- **Routing**: Define paths in `lib/presentation/router/app_routes.dart` and register them in `feature_routes.dart` or `app_router.dart`.
- **Styling**: Strictly adhere to the theme tokens defined in `lib/core/theme/` (monochrome minimalist design system). Avoid hardcoded colors.

---

## 4. Git Commit Guidelines

Commit messages must follow Conventional Commits:
- `feat: <description>` for new features or user-facing changes.
- `fix: <description>` for bug fixes and analyzer cleanups.
- `refactor: <description>` for file decomposition and LOC compliance.
- `docs: <description>` for documentation updates.
- `test: <description>` for unit/widget test additions.
