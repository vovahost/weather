import 'package:flutter/material.dart';
import 'package:weather/domain/weather/model/daily_model.dart';
import 'package:weather/presentation/shared/resources/app_images.dart';
import 'package:weather/presentation/shared/resources/app_text_styles.dart';
import 'package:weather/presentation/shared/utils/utils.dart';

class DailyWeatherWidget extends StatelessWidget {
  const DailyWeatherWidget({Key? key, required this.dailyWeather})
      : super(key: key);
  final List<DailyWeather> dailyWeather;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: dailyWeather.length,
          itemBuilder: (context, index) {
            if (index == 0) {
              return const SizedBox();
            }
            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: size.width * 0.3,
                    child: Text(
                      getDayFromEpoch(dailyWeather[index].dt),
                      style: subTitleTextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ).copyWith(color: Colors.indigo),
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.09,
                    child: Image.asset(
                      AppImages.getSmallAsset(
                          dailyWeather[index].weather.first.icon),
                      width: size.width * 0.09,
                    ),
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  Text(
                    '${dailyWeather[index].temp.max}°',
                    style: titleTextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ).copyWith(color: Colors.black87),
                  ),
                  Text(
                    '${dailyWeather[index].temp.min}°',
                    style: subTitleTextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ).copyWith(color: Colors.black54),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
