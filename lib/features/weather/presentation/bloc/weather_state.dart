part of 'weather_bloc.dart';

sealed class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

final class WeatherInitial extends WeatherState {}

final class WeatherLoading extends WeatherState {}

final class WeatherLocationDisable extends WeatherState {
  final String message;

  const WeatherLocationDisable(this.message);

  @override
  List<Object> get props => [message];
}

final class WeatherSuccess extends WeatherState {
  final List<Weather> fiveDaysWeather;
  final Weather currentWeather;

  const WeatherSuccess({
    required this.currentWeather,
    required this.fiveDaysWeather,
  });

  @override
  List<Object> get props => [
        currentWeather,
        fiveDaysWeather,
      ];
}

final class WeatherFailure extends WeatherState {
  final String message;

  const WeatherFailure(this.message);

  @override
  List<Object> get props => [message];
}
