import 'package:flutter/material.dart';

class ColorModel {
  final Color backgroundColor;
  final Color textColor;

  ColorModel({
    required this.backgroundColor,
    required this.textColor,
  });
}

ColorModel getBGWeatherCondition(int id) {
  /**
     * 
     * check the official openweathermap id
     * https://openweathermap.org/weather-conditions
     * 
     */

  if (id >= 200 && id <= 232) {
    // Thunderstorm
    return ColorModel(
      backgroundColor: const Color(0xFF2D3656),
      textColor: Colors.white,
    );
  } else if (id >= 300 && id <= 321) {
    // Drizle
    return ColorModel(
      backgroundColor: const Color(0xFF91B2B1),
      textColor: Colors.black,
    );
  } else if (id >= 500 && id <= 531) {
    // Rain
    return ColorModel(
      backgroundColor: const Color(0xFF0976F5),
      textColor: Colors.white,
    );
  } else if (id >= 600 && id <= 622) {
    // Snow
    return ColorModel(
      backgroundColor: const Color(0xFF5C72D1),
      textColor: Colors.white,
    );
  } else if (id >= 701 && id <= 781) {
    // Atmoshphere
    return ColorModel(
      backgroundColor: const Color(0xFFF77B57),
      textColor: Colors.white,
    );
  } else if (id >= 801 && id <= 804) {
    // Clouds
    return ColorModel(
      backgroundColor: const Color(0xFFDED7D3),
      textColor: Colors.black,
    );
  } else {
    // Clear Sky
    return ColorModel(
      backgroundColor: const Color(0xFFFFFFFF),
      textColor: Colors.black,
    );
  }
}
