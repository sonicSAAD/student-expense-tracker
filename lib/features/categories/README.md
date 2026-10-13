# Categories

## Responsibility

Provides category definitions, lookups, and updates used by transactions, budgets, and other features.

## Main files

- `features/categories/service/category_service.dart`

## Entry points

- Service: `CategoryService`
- State: `categoriesProvider`

## Failure behavior

- Reads return empty lists on storage issues instead of propagating exceptions.
- Lookups return null when a category is missing.
- Updates are best-effort storage operations.

## Dependencies

- `HiveService`
