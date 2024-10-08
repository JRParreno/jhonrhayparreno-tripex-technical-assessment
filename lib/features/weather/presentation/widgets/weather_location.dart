import 'package:flutter/material.dart';

class WeatherLocation extends StatelessWidget {
  const WeatherLocation(
      {super.key,
      required this.country,
      required this.areaName,
      required this.textColor});

  final String country;
  final String areaName;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        Icon(
          Icons.location_on_outlined,
          color: textColor.withOpacity(0.75),
          size: 25,
        ),
        Text(
          '$country, $areaName',
          style: textTheme.headlineSmall!.apply(
            color: textColor.withOpacity(0.75),
          ),
        )
      ],
    );
  }
}
