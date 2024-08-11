import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jhon_rhay_parreno_technical_assessment/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:jhon_rhay_parreno_technical_assessment/generated/l10n.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final language = S.of(context);
    final textTheme = Theme.of(context).textTheme;

    return AlertDialog(
      title: Text(
        language.logout,
        style: textTheme.labelMedium,
      ),
      content: Text(
        language.areYouSureYouWantToLogout,
        style: textTheme.labelSmall,
      ),
      actions: [
        TextButton(
          onPressed: () {
            // Dismiss the dialog and do nothing
            Navigator.of(context).pop();
          },
          child: Text(
            language.cancel,
            style: textTheme.labelSmall,
          ),
        ),
        TextButton(
          key: const Key('logoutDialogButton'),
          onPressed: () {
            // Perform logout operation
            _logout(context);
          },
          child: Text(
            language.logout,
            style: textTheme.labelSmall,
          ),
        ),
      ],
    );
  }

  void _logout(BuildContext context) {
    context.read<AuthBloc>().add(AuthUserLogout());
    Navigator.of(context).pop(); // Close the dialog
  }
}
