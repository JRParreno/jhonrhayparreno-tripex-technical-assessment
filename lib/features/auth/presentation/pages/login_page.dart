import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jhon_rhay_parreno_technical_assessment/core/common/widgets/loader.dart';
import 'package:jhon_rhay_parreno_technical_assessment/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:jhon_rhay_parreno_technical_assessment/features/auth/presentation/widgets/login_footer.dart';
import 'package:jhon_rhay_parreno_technical_assessment/gen/assets.gen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: SafeArea(
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthLoading) {
                LoadingScreen.instance().show(context: context);
              }

              if (state is AuthFailure || state is AuthSuccess) {
                Future.delayed(const Duration(milliseconds: 500), () {
                  LoadingScreen.instance().hide();
                });
              }

              if (state is AuthFailure) {
                onFormError(state.message);
              }
            },
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.blue,
                      ),
                      child: Assets.lottie.weatherLoading.lottie(),
                    ),
                    const LoginFooter(),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void onFormError(String message) {
    final snackBar = SnackBar(
      content: Text(message),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
