# Savings Goals

## Responsibility

Creates and tracks savings goals, adds money toward them, and shows completion state.

## Main files

- `features/savings_goals/service/savings_goal_service.dart`
- `presentation/features/savings_goals/screen/savings_goals_screen.dart`

## Entry points

- UI: `SavingsGoalsScreen`
- State: `savingsGoalsProvider`
- Service: `SavingsGoalService`

## Failure behavior

- Reads return empty lists on storage issues.
- Add money loads the goal first and no-ops if it is missing.
- Updates and deletes are best-effort storage operations.

## Dependencies

- `HiveService`
