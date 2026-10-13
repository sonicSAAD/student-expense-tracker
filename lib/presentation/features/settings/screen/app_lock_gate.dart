import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_auth/local_auth.dart';
import 'package:student_expense_tracker/presentation/providers/app_providers.dart';

class AppLockGate extends ConsumerStatefulWidget {
  const AppLockGate({super.key, required this.child});
  final Widget child;

  @override
  ConsumerState<AppLockGate> createState() => _AppLockGateState();
}

class _AppLockGateState extends ConsumerState<AppLockGate> {
  bool _unlocked = false;
  final _auth = LocalAuthentication();

  @override
  void initState() {
    super.initState();
    _checkLock();
  }

  Future<void> _checkLock() async {
    final s = ref.read(settingsProvider);
    if (!s.appLockEnabled) return setState(() => _unlocked = true);
    if (s.biometricEnabled && await _auth.canCheckBiometrics) {
      final ok = await _auth.authenticate(localizedReason: 'Unlock App');
      if (ok) setState(() => _unlocked = true);
    }
  }

  Future<void> _showPinDialog(String? expectedPin) async {
    final ctrl = TextEditingController();
    final pin = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Enter PIN'),
        content: TextField(controller: ctrl, obscureText: true),
        actions: [FilledButton(onPressed: () => Navigator.pop(ctx, ctrl.text), child: const Text('Unlock'))],
      ),
    );
    if (pin != null && pin == expectedPin) setState(() => _unlocked = true);
  }

  @override
  Widget build(BuildContext context) {
    final s = ref.watch(settingsProvider);
    if (!s.appLockEnabled || _unlocked) return widget.child;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.lock, size: 64),
            const SizedBox(height: 16),
            const Text('App Locked'),
            const SizedBox(height: 24),
            FilledButton(onPressed: () => _showPinDialog(s.appLockPin), child: const Text('Enter PIN')),
          ],
        ),
      ),
    );
  }
}
