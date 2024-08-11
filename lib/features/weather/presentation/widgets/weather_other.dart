import 'package:flutter/material.dart';
import 'package:jhon_rhay_parreno_technical_assessment/core/extension/spacer_widgets.dart';

class WeatherOther extends StatelessWidget {
  const WeatherOther({
    super.key,
    required this.humidity,
    required this.windSpeed,
    required this.textColor,
  });

  final double humidity;
  final double windSpeed;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Icon(
              Icons.water_drop_outlined,
              color: textColor,
              size: 20,
            ),
            Text(
              '${humidity.toInt()} %',
              style: textTheme.bodyMedium!.apply(
                color: textColor,
              ),
            )
          ].withSpaceBetween(height: 15),
        ),
        const SizedBox(
          width: 10,
        ),
        Column(
          children: [
            Icon(
              Icons.air_outlined,
              color: textColor,
              size: 20,
            ),
            Text(
              '$windSpeed m/s',
              style: textTheme.bodyMedium!.apply(
                color: textColor,
              ),
            )
          ].withSpaceBetween(height: 15),
        )
      ],
    );
  }
}
