import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jhon_rhay_parreno_technical_assessment/core/colors/weather_color.dart';
import 'package:jhon_rhay_parreno_technical_assessment/features/weather/presentation/widgets/index.dart';
import 'package:weather/weather.dart';

class CurrentWeather extends StatelessWidget {
  const CurrentWeather({
    super.key,
    required this.weather,
  });

  final Weather weather;

  @override
  Widget build(BuildContext context) {
    final weatherConditionColor =
        getBGWeatherCondition(weather.weatherConditionCode ?? 0);

    final textTheme = Theme.of(context).textTheme;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: weatherConditionColor.backgroundColor,
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 10,
          )
        ],
      ),
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          WeatherCelsiusCloud(
            date: weather.date!,
            temperature: weather.temperature?.celsius?.toInt().toString() ?? '',
            tempFeelsLike:
                weather.tempFeelsLike?.celsius?.toInt().toString() ?? '',
            icon: weather.weatherIcon ?? '',
            textColor: weatherConditionColor.textColor,
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: double.infinity,
            child: FittedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FittedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${toBeginningOfSentenceCase(weather.weatherDescription)}',
                          style: textTheme.headlineSmall!.apply(
                            color: weatherConditionColor.textColor,
                          ),
                          maxLines: 1,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        WeatherTemperature(
                          lowTemp:
                              '${weather.tempMin?.celsius?.toInt().toString()}°',
                          highTemp:
                              '${weather.tempMax?.celsius?.toInt().toString()}°',
                          textColor: weatherConditionColor.textColor,
                        ),
                      ],
                    ),
                  ),
                  FittedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        WeatherOther(
                          humidity: weather.humidity ?? 0,
                          windSpeed: weather.windSpeed ?? 0,
                          textColor: weatherConditionColor.textColor,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        WeatherLocation(
                          areaName: weather.areaName ?? '',
                          country: weather.country ?? '',
                          textColor: weatherConditionColor.textColor,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
