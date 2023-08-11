import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/domain/weather/model/current_weather.dart';
import 'package:weather/presentation/shared/resources/app_images.dart';
import 'package:weather/presentation/shared/resources/app_text_styles.dart';
import 'package:weather/presentation/shared/utils/utils.dart';

class HourlyWeatherWidget extends StatelessWidget {
  final List<CurrentWeather> hourWeatherList;

  const HourlyWeatherWidget({
    Key? key,
    required this.hourWeatherList,
  }) : super(key: key);

  static final _timeFormat = DateFormat('HH:mm');

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.15,
      child: ListView.builder(
        itemCount: hourWeatherList.length,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          if (index == 0) {
            return const SizedBox();
          }
          final hourWeather = hourWeatherList[index];
          final dateTime =
              DateTime.fromMillisecondsSinceEpoch(hourWeather.dt * 1000);
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
            child: Column(
              children: [
                const Space(height: 4),
                Text(
                  '${hourWeather.temp}°',
                  style:
                      titleTextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Image.asset(
                  AppImages.getSmallAsset(
                    hourWeather.weather.first.icon,
                  ),
                  height: size.height * 0.05,
                ),
                const Space(height: 5),
                Text(
                  _timeFormat.format(dateTime),
                  style:
                  titleTextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
