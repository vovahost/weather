import 'package:flutter/material.dart';
import 'package:weather/domain/weather/model/current_weather.dart';
import 'package:weather/presentation/shared/resources/app_images.dart';
import 'package:weather/presentation/shared/resources/app_text_styles.dart';
import 'package:weather/presentation/shared/utils/utils.dart';

class HourlyWeatherWidget extends StatelessWidget {
  const HourlyWeatherWidget({
    Key? key,
    required this.hourWeather,
  }) : super(key: key);

  final List<CurrentWeather> hourWeather;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.15,
      child: ListView.builder(
          itemCount: hourWeather.length,
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            if (index == 0) {
              return const SizedBox();
            }
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              child: Column(
                children: [
                  const Space(height: 5),
                  Image.asset(
                    AppImages.getSmallAsset(
                        hourWeather[index].weather.first.icon),
                    height: size.height * 0.05,
                  ),
                  const Space(height: 8),
                  Text(
                    '${hourWeather[index].temp}°',
                    style: titleTextStyle(
                        fontSize: 23, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
