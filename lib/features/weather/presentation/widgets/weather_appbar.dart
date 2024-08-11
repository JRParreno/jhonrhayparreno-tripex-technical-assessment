import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jhon_rhay_parreno_technical_assessment/core/common/cubit/app_user_cubit.dart';
import 'package:jhon_rhay_parreno_technical_assessment/core/common/entities/user_entity.dart';
import 'package:jhon_rhay_parreno_technical_assessment/core/theme/app_pallete.dart';
import 'package:jhon_rhay_parreno_technical_assessment/features/weather/presentation/widgets/logout_dialog.dart';

PreferredSizeWidget weatherAppbar(BuildContext context) {
  return AppBar(
    toolbarHeight: kToolbarHeight,
    titleSpacing: 0,
    backgroundColor: AppPallete.primaryColor,
    centerTitle: true,
    actions: [
      IconButton(
        key: const Key('logoutButton'),
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return const LogoutDialog();
            },
          );
        },
        icon: const Icon(
          Icons.logout,
          color: AppPallete.whiteColor,
        ),
      ),
    ],
    title: BlocSelector<AppUserCubit, AppUserState, UserEntity?>(
      selector: (state) {
        if (state is AppUserLoggedIn) {
          return state.user;
        }

        return null;
      },
      builder: (context, state) {
        const notLoggedText = 'Not logged in';
        final name =
            state != null ? state.name ?? notLoggedText : notLoggedText;

        return Text(
          name,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: AppPallete.whiteColor,
              ),
        );
      },
    ),
  );
}
