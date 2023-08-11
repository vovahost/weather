import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather/domain/weather/model/current_weather.dart';

class WeatherDetailsWidget extends StatelessWidget {
  const WeatherDetailsWidget({
    Key? key,
    required this.currentWeather,
    required this.cimage,
  }) : super(key: key);

  final CurrentWeather currentWeather;
  final String cimage;

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.only(left: 35.0, right: 35.0),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 2.5,
        crossAxisCount: 2,
      ),
      children: [
        HeadingDetailWidget(
          title: "Humidity",
          value: '${currentWeather.humidity}%',
          cimage: cimage,
        ),
        HeadingDetailWidget(
          title: "Wind Speed",
          value: '${currentWeather.windSpeed} m/s',
          cimage: cimage,
        ),
        HeadingDetailWidget(
          title: "Pressure",
          value: '${currentWeather.pressure} hPa',
          cimage: cimage,
        ),
        HeadingDetailWidget(
          title: "UV",
          value: '${currentWeather.uvi}',
          cimage: cimage,
        ),
        HeadingDetailWidget(
          title: "Visibility",
          value: '${currentWeather.visibility} km',
          cimage: cimage,
        ),
        HeadingDetailWidget(
          title: "Cloudiness",
          value: '${currentWeather.clouds}%',
          cimage: cimage,
        ),
      ],
    );
  }
}

class HeadingDetailWidget extends StatelessWidget {
  final String title;
  final String value;
  final String? cimage;

  const HeadingDetailWidget({
    Key? key,
    required this.title,
    required this.value,
    this.cimage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: GoogleFonts.montserrat(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.montserrat(
            fontSize: 20,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
