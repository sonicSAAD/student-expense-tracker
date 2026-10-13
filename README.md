# Student Expense Tracker

[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.6+-0175C2?logo=dart&logoColor=white)](https://dart.dev)
[![Architecture](https://img.shields.io/badge/LOC_Rule-%E2%89%A4_65_per_file-brightgreen)](docs/ARCHITECTURE.md)
[![Storage](https://img.shields.io/badge/Storage-100%25_Offline_Hive-orange)](https://pub.dev/packages/hive)
[![State](https://img.shields.io/badge/State-Riverpod_2.x-blue)](https://riverpod.dev)
[![License](https://img.shields.io/badge/License-Restrictive-red)](LICENSE)
[![GitHub](https://img.shields.io/badge/Maintained_by-sonicSAAD-black?logo=github)](https://github.com/sonicSAAD)

An elegant, offline-first personal financial management application built with Flutter and Dart, specifically designed for students. Featuring a focused minimalist monochrome aesthetic, real-time budgeting, split expenses, bill reminders, and strict high-modularity architecture.

---

## 🌟 Key Features

| Domain | Description |
|---|---|
| **📊 Dashboard** | Real-time aggregate balance, monthly income/expense metrics, budget health, and recent activities. |
| **💳 Transactions** | Instant logging with account attribution, categorized tags, note search, and filters. |
| **🎯 Budgets** | Set monthly spending limits per category with dynamic warning thresholds (80% near limit, 100% over limit). |
| **🏦 Multi-Account** | Track Cash, Bank, Digital Wallets, and Savings with atomic balance transfers between accounts. |
| **🗓️ Recurring Bills** | Track weekly and monthly subscriptions with scheduled local reminder notifications. |
| **🐖 Savings Goals** | Visual progress tracking towards milestones with flexible contribution deposits. |
| **👥 Split Expenses** | Effortlessly split shared meals, rent, or group project bills with per-person settlement status. |
| **📈 Analytics & Export** | Visual category spending charts (`fl_chart`), with one-tap CSV and formatted PDF reports (`printing`). |
| **🔒 App Security** | Protect sensitive financial records using a 4-digit PIN lock and biometric authentication (`local_auth`). |
| **💾 100% Offline** | Zero cloud tracking or account signup required. Fast local Hive key-value storage with JSON backup/restore. |

---

## 🏛️ The Strict $\le 65$ LOC Architecture

To ensure unmatched code cleanliness, rapid testability, and zero cognitive load, this codebase enforces the **Strict $\le 65$ LOC Rule**:

- **Every single `.dart` file is capped at $\le 65$ lines of code**.
- Monolithic classes and bloated widgets are decomposed into:
  - Focused single-concern widgets (`presentation/features/*/widgets/` or `screen/`)
  - Dedicated domain entities and pure usecase calculators (`domain/entities/`, `domain/usecases/`)
  - Standalone data mappers (`data/mappers/`)
  - Scoped Riverpod providers (`presentation/providers/`)
- All 113 Dart files in the codebase comply 100% with this rule.

---

## 📁 Project Directory Map

```text
lib/
├── app.dart                                # Top-level MaterialApp and theme binding
├── main.dart                               # Entry point, Hive & Notification initialization
├── core/
│   ├── constants/                          # System keys and box definitions
│   ├── services/                           # Hive storage and local notification wrappers
│   ├── theme/                              # Monochrome design tokens and dark/light palettes
│   └── utils/                              # Date, currency, and icon resolution helpers
├── data/
│   └── mappers/                            # Pure conversion mappers between entities & Hive maps
├── domain/
│   ├── entities/                           # Immutable models extending Equatable
│   └── usecases/                           # Pure financial calculators (budget, bills, splits)
├── features/                               # Feature business logic services
│   ├── accounts/service/                   # Account and transfer operations
│   ├── analytics/                          # Analytics helpers
│   ├── backup/service/                     # JSON export and import
│   ├── budgets/service/                    # Budget limits and recheck services
│   ├── categories/service/                 # Category operations
│   ├── recurring_bills/service/            # Bill tracking and mark-as-paid operations
│   ├── savings_goals/service/              # Goal progress and deposit operations
│   ├── settings/service/                   # User preferences
│   ├── split_expenses/service/             # Group split settlement operations
│   └── transactions/service/               # Transaction persistence and balance sync
└── presentation/
    ├── features/                           # Feature UI modules (screens & sub-widgets)
    │   ├── accounts/                       # Accounts & transfer dialogs
    │   ├── analytics/                      # Spending charts & export sheets
    │   ├── budgets/                        # Budget card items & overview headers
    │   ├── home/                           # Dashboard cards, sections & summary widgets
    │   ├── onboarding/                     # First-launch setup flow
    │   ├── recurring_bills/                # Bill lists, tiles & edit dialogs
    │   ├── savings_goals/                  # Goal cards & contribute dialogs
    │   ├── settings/                       # Security lock gate & settings menus
    │   ├── shell/                          # Bottom navigation bar & scaffold shell
    │   ├── split_expenses/                 # Split tiles & participant checklists
    │   └── transactions/                   # Transaction list, search & add dialogs
    ├── providers/                          # Scoped Riverpod providers & feature service bundles
    ├── router/                             # Declarative go_router routes
    └── widgets/                            # Reusable widgets (progress bars, empty states, tiles)
```

---

## 🚀 Getting Started

### Prerequisites
- [Flutter SDK](https://flutter.dev/docs/get-started/install) (`>= 3.6.0`)
- [Dart SDK](https://dart.dev/get-dart)
- Android Studio / VS Code / Antigravity IDE with Flutter extensions

### Installation

```bash
# 1. Clone the repository
git clone https://github.com/sonicSAAD/student-expense-tracker.git
cd student-expense-tracker

# 2. Install dependencies
flutter pub get

# 3. Run static analyzer (0 errors, 0 warnings guaranteed)
flutter analyze

# 4. Run automated test suite
flutter test

# 5. Launch the application
flutter run
```

---

## 📚 Documentation

Detailed documentation is available in the [`docs/`](docs/) directory:

- 🏗️ [**Architecture & Design System**](docs/ARCHITECTURE.md) — Comprehensive architectural breakdown and design principles.
- 🎯 [**Feature Guide**](docs/FEATURES.md) — Deep dive into all 10 core capability modules.
- ⚙️ [**API, Services & State Reference**](docs/API_AND_SERVICES.md) — Detailed service layer APIs, domain calculators, and Riverpod providers.
- 🤝 [**Contributing & Standards**](docs/CONTRIBUTING.md) — Workflow guidelines, 65 LOC validation scripts, and testing standards.

---

## 🛠️ Technology Stack

| Category | Technology |
|---|---|
| **Framework** | Flutter (Material 3) |
| **Language** | Dart 3.6+ |
| **State Management** | Flutter Riverpod |
| **Local Persistence** | Hive & Hive Flutter |
| **Routing** | GoRouter |
| **Visual Charts** | FL Chart |
| **Reporting** | PDF, Printing & CSV |
| **Device Security** | Local Auth (Biometric & PIN) |
| **Notifications** | Flutter Local Notifications & Timezone |
| **Sharing** | Share Plus |

---

## 👤 Author

**Mohammad Saad (`sonicSAAD`)**
- GitHub: [@sonicSAAD](https://github.com/sonicSAAD)
- Repository: [https://github.com/sonicSAAD/student-expense-tracker](https://github.com/sonicSAAD/student-expense-tracker)

---

## 📄 License

This repository is private and restrictive. Copyright (c) 2026 Mohammad Saad ([sonicSAAD](https://github.com/sonicSAAD)). All rights reserved. See [`LICENSE`](LICENSE) for full details.
