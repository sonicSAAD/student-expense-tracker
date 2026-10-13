import 'package:equatable/equatable.dart';
import 'package:student_expense_tracker/domain/entities/enums.dart';

class AppSettings extends Equatable {
  const AppSettings({
    this.currencyCode = 'USD',
    this.currencySymbol = '\$',
    this.themePreference = ThemePreference.system,
    this.notificationsEnabled = true,
    this.onboardingCompleted = false,
    this.appLockEnabled = false,
    this.appLockPin,
    this.biometricEnabled = false,
  });

  final String currencyCode;
  final String currencySymbol;
  final ThemePreference themePreference;
  final bool notificationsEnabled;
  final bool onboardingCompleted;
  final bool appLockEnabled;
  final String? appLockPin;
  final bool biometricEnabled;

  AppSettings copyWith({
    String? currencyCode,
    String? currencySymbol,
    ThemePreference? themePreference,
    bool? notificationsEnabled,
    bool? onboardingCompleted,
    bool? appLockEnabled,
    String? appLockPin,
    bool? biometricEnabled,
    bool clearPin = false,
  }) {
    return AppSettings(
      currencyCode: currencyCode ?? this.currencyCode,
      currencySymbol: currencySymbol ?? this.currencySymbol,
      themePreference: themePreference ?? this.themePreference,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      onboardingCompleted: onboardingCompleted ?? this.onboardingCompleted,
      appLockEnabled: appLockEnabled ?? this.appLockEnabled,
      appLockPin: clearPin ? null : (appLockPin ?? this.appLockPin),
      biometricEnabled: biometricEnabled ?? this.biometricEnabled,
    );
  }

  @override
  List<Object?> get props => [
        currencyCode,
        currencySymbol,
        themePreference,
        notificationsEnabled,
        onboardingCompleted,
        appLockEnabled,
        appLockPin,
        biometricEnabled,
      ];
}
