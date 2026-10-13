import 'package:student_expense_tracker/domain/entities/app_settings.dart';
import 'package:student_expense_tracker/domain/entities/enums.dart';

class SettingsMapper {
  static Map<String, dynamic> toMap(AppSettings s) => {
        'currencyCode': s.currencyCode,
        'currencySymbol': s.currencySymbol,
        'themePreference': s.themePreference.name,
        'notificationsEnabled': s.notificationsEnabled,
        'onboardingCompleted': s.onboardingCompleted,
        'appLockEnabled': s.appLockEnabled,
        'appLockPin': s.appLockPin,
        'biometricEnabled': s.biometricEnabled,
      };

  static AppSettings fromMap(Map map) => AppSettings(
        currencyCode: map['currencyCode'] as String? ?? 'USD',
        currencySymbol: map['currencySymbol'] as String? ?? '\$',
        themePreference: ThemePreference.values
            .byName(map['themePreference'] as String? ?? 'system'),
        notificationsEnabled: map['notificationsEnabled'] as bool? ?? true,
        onboardingCompleted: map['onboardingCompleted'] as bool? ?? false,
        appLockEnabled: map['appLockEnabled'] as bool? ?? false,
        appLockPin: map['appLockPin'] as String?,
        biometricEnabled: map['biometricEnabled'] as bool? ?? false,
      );
}
