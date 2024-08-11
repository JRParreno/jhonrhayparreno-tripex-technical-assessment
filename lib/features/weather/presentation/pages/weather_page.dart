import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:jhon_rhay_parreno_technical_assessment/core/extension/spacer_widgets.dart';
import 'package:jhon_rhay_parreno_technical_assessment/core/permission/app_permission.dart';
import 'package:jhon_rhay_parreno_technical_assessment/core/theme/app_pallete.dart';
import 'package:jhon_rhay_parreno_technical_assessment/features/weather/presentation/bloc/weather_bloc.dart';
import 'package:jhon_rhay_parreno_technical_assessment/features/weather/presentation/pages/body/current_weather.dart';
import 'package:jhon_rhay_parreno_technical_assessment/features/weather/presentation/pages/body/five_days_weather.dart';
import 'package:jhon_rhay_parreno_technical_assessment/features/weather/presentation/widgets/index.dart';
import 'package:jhon_rhay_parreno_technical_assessment/gen/assets.gen.dart';
import 'package:jhon_rhay_parreno_technical_assessment/generated/l10n.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  static const String routeName = 'weather/v2';

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  bool isConnectedToInternet = true;
  StreamSubscription? _internetConnectionStreamSubscription;
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();
    checkInternetConnection();
    handleGetCurrentWeather();
  }

  @override
  void dispose() {
    _internetConnectionStreamSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final language = S.of(context);

    return Scaffold(
      appBar: weatherAppbar(context),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocConsumer<WeatherBloc, WeatherState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is WeatherLoading) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Assets.lottie.weatherLoading.lottie(),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(language.loadingPleaseWait),
                  ],
                ),
              );
            }

            if (state is WeatherFailure) {
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(language.somethingWentWrongTryAgain),
                      ElevatedButton(
                        onPressed: () {
                          context.read<WeatherBloc>().add(GetWeatherEvent());
                        },
                        child: Text(
                          language.tryAgain,
                          style: const TextStyle(
                            color: AppPallete.whiteColor,
                          ),
                        ),
                      ),
                    ].withSpaceBetween(height: 30),
                  ),
                ),
              );
            }

            if (state is WeatherLocationDisable) {
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(language.locationDisable),
                      ElevatedButton(
                        onPressed: handleOpenLocationSettings,
                        child: Text(
                          language.tryAgain,
                          style: const TextStyle(
                            color: AppPallete.whiteColor,
                          ),
                        ),
                      ),
                    ].withSpaceBetween(height: 30),
                  ),
                ),
              );
            }

            if (state is WeatherSuccess) {
              final currentWeather = state.currentWeather;

              return RefreshIndicator(
                onRefresh: () {
                  handleGetCurrentWeather();
                  return Future<void>.value();
                },
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CurrentWeather(
                          weather: currentWeather,
                        ),
                        Column(
                          children: state.fiveDaysWeather
                              .map((weather) =>
                                  FiveDaysWeather(weather: weather))
                              .toList(),
                        )
                      ].withSpaceBetween(height: 15),
                    ),
                  ),
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  void checkInternetConnection() {
    _internetConnectionStreamSubscription =
        InternetConnection().onStatusChange.listen((event) {
      switch (event) {
        case InternetStatus.connected:
          setState(() => isConnectedToInternet = true);
          break;
        case InternetStatus.disconnected:
          setState(() => isConnectedToInternet = false);
          break;
        default:
          setState(() => isConnectedToInternet = false);
      }

      if (!isConnectedToInternet) {
        final snackBar = SnackBar(
          content: Text(
            "You are disconnected to the internet.",
            style: Theme.of(context)
                .textTheme
                .labelSmall
                ?.copyWith(color: AppPallete.whiteColor),
          ),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    });
  }

  void handleGetCurrentWeather() {
    context.read<WeatherBloc>().add(GetWeatherEvent());
  }

  void handleOpenLocationSettings() async {
    final isGranted = await PermissionServiceImpl().locationPermission();
    if (isGranted) {
      handleGetCurrentWeather();
      return;
    }
    await Geolocator.openLocationSettings();
  }
}
