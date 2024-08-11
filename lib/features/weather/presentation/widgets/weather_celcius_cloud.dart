import 'package:flutter/material.dart';
import 'package:jhon_rhay_parreno_technical_assessment/features/weather/presentation/widgets/index.dart';

class WeatherCelsiusCloud extends StatelessWidget {
  const WeatherCelsiusCloud({
    super.key,
    required this.temperature,
    required this.tempFeelsLike,
    required this.icon,
    required this.date,
    required this.textColor,
  });

  final String temperature;
  final String tempFeelsLike;
  final String icon;
  final DateTime date;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    String iconUrl = "https://openweathermap.org/img/wn/$icon@4x.png";
    final textTheme = Theme.of(context).textTheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        Flexible(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WeatherDate(
                date: date,
                textColor: textColor,
              ),
              Text(
                '$temperature°',
                style: TextStyle(
                  fontSize: 90,
                  color: textColor,
                ),
              ),
              Text(
                'Feels like $tempFeelsLike°',
                style: textTheme.bodyMedium!.apply(
                  fontWeightDelta: 4,
                  color: textColor.withOpacity(0.75),
                ),
              ),
            ],
          ),
        ),
        WeatherIconImage(
          iconUrl: iconUrl,
          size: 150,
        )
      ],
    );
  }
}
