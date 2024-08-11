import 'package:flutter/material.dart';
import 'package:jhon_rhay_parreno_technical_assessment/core/extension/spacer_widgets.dart';

class WeatherTemperature extends StatelessWidget {
  final String lowTemp;
  final String highTemp;
  final Color textColor;
  const WeatherTemperature({
    super.key,
    required this.lowTemp,
    required this.highTemp,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Temp Max/Min',
          style: textTheme.bodyMedium!.apply(
            color: textColor,
          ),
        ),
        Row(
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.arrow_upward,
                  color: textColor,
                  size: 15,
                ),
                Text(
                  highTemp,
                  style: textTheme.bodyMedium!.apply(
                    color: textColor,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.arrow_downward,
                  color: textColor,
                  size: 15,
                ),
                Text(
                  lowTemp,
                  style: textTheme.bodyMedium!.apply(
                    color: textColor,
                  ),
                ),
              ],
            )
          ].withSpaceBetween(height: 10),
        ),
      ].withSpaceBetween(height: 10),
    );
  }
}
