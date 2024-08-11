import 'package:flutter/material.dart';
import 'package:jhon_rhay_parreno_technical_assessment/core/colors/weather_color.dart';
import 'package:jhon_rhay_parreno_technical_assessment/features/weather/presentation/widgets/index.dart';
import 'package:weather/weather.dart';

class FiveDaysWeather extends StatelessWidget {
  const FiveDaysWeather({
    super.key,
    required this.weather,
  });

  final Weather weather;

  @override
  Widget build(BuildContext context) {
    String iconUrl =
        "https://openweathermap.org/img/wn/${weather.weatherIcon}@4x.png";
    final textTheme = Theme.of(context).textTheme;
    final weatherConditionColor =
        getBGWeatherCondition(weather.weatherConditionCode ?? 0);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: weatherConditionColor.backgroundColor,
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 3,
          )
        ],
      ),
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
          WeatherIconImage(iconUrl: iconUrl, size: 100),
          Text(
            '${weather.temperature?.celsius?.toInt().toString()}° C',
            style: textTheme.displayMedium?.copyWith(
              color: weatherConditionColor.textColor,
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          WeatherDate(
            date: weather.date!,
            textColor: weatherConditionColor.textColor,
            axis: Axis.vertical,
          )
        ],
      ),
    );
  }
}
