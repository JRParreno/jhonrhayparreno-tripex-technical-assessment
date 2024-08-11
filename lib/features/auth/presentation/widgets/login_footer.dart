import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jhon_rhay_parreno_technical_assessment/core/extension/spacer_widgets.dart';
import 'package:jhon_rhay_parreno_technical_assessment/core/theme/app_pallete.dart';
import 'package:jhon_rhay_parreno_technical_assessment/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:jhon_rhay_parreno_technical_assessment/gen/assets.gen.dart';
import 'package:jhon_rhay_parreno_technical_assessment/generated/l10n.dart';

class LoginFooter extends StatelessWidget {
  const LoginFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final language = S.of(context);
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 15),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: AppPallete.primaryColor,
        ),
        borderRadius: BorderRadius.circular(
          20,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              language.weatherApp,
              style: textTheme.titleMedium?.copyWith(
                color: AppPallete.primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
          ),
          Text(
            language.welcomeBackYouveBeenMiseed,
            style: textTheme.labelSmall?.copyWith(
              color: AppPallete.primaryColor,
            ),
          ),
          Text(
            language.toContinuePleaseUseGoogleAccount,
            style: textTheme.labelSmall?.copyWith(
              color: AppPallete.primaryColor,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: GestureDetector(
              key: const Key('googleSignInButton'),
              onTap: () {
                context.read<AuthBloc>().add(AuthGoogleSignInEvent());
              },
              child: Container(
                decoration: BoxDecoration(
                    border:
                        Border.all(color: AppPallete.primaryColor, width: 5),
                    borderRadius: BorderRadius.circular(15)),
                padding: const EdgeInsets.all(25),
                height: 100,
                width: 100,
                child: Assets.images.icon.google.image(),
              ),
            ),
          ),
        ].withSpaceBetween(height: 20),
      ),
    );
  }
}
