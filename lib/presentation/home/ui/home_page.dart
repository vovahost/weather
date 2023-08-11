import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:weather/domain/weather/model/weather_forecast.dart';
import 'package:weather/presentation/home/bloc/home_bloc.dart';
import 'package:weather/presentation/shared/resources/app_colors.dart';
import 'package:weather/presentation/shared/resources/app_images.dart';
import 'package:weather/presentation/shared/resources/app_text_styles.dart';
import 'package:weather/presentation/shared/utils/utils.dart';
import 'package:weather/presentation/shared/widgets/dialy_weather_widget.dart';
import 'package:weather/presentation/shared/widgets/hourly_weather_widget.dart';
import 'package:weather/presentation/shared/widgets/weather_detail_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String getCurrentMode() {
    var timeNow = DateTime.now().hour;

    if (timeNow <= 17) {
      return 'night';
    } else {
      return 'day';
    }
  }

  @override
  void initState() {
    getCurrentMode();

    super.initState();
  }

  final PanelController _controller = PanelController();

  void togglePanel() =>
      _controller.isPanelOpen ? _controller.close() : _controller.open();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocProvider(
        create: (context) => HomeBloc(),
        child: BlocConsumer<HomeBloc, HomeState>(
          listener: (context, state) {
            if (state is HomeFailed) {
              showSnackBar(context, state.error);
            }
          },
          builder: (context, state) {
            if (state is HomeLoading) {
              return const Loading();
            }
            if (state is HomeSuccess) {
              final weather = state.weatherData;
              return SlidingUpPanel(
                controller: _controller,
                boxShadow: const [],
                parallaxEnabled: true,
                maxHeight: size.height * 0.7,
                minHeight: size.height * 0.22,
                color: Colors.transparent,
                body: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(weather.currentWeatherBgImage),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: size.width * 0.25,
                        right: size.width * 0.09,
                        child: Image.asset(
                          AppImages.getAsset(weather.current.weather.first.icon),
                          height: size.height * 0.1,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: size.width * 0.6,
                            padding: EdgeInsets.only(
                                left: size.width * 0.08,
                                right: size.width * 0.08,
                                bottom: 20.0,
                                top: size.height * 0.09),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  state.place,
                                  style: GoogleFonts.montserrat(
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                    shadows: <Shadow>[
                                      const Shadow(
                                        offset: Offset(0.0, 0.0),
                                        blurRadius: 8.0,
                                        color: Colors.black38,
                                      ),
                                    ],
                                  ),
                                ),
                                const Space(height: 16),
                                Text(
                                  '${weather.current.temp}°',
                                  style: titleTextStyle(fontSize: 54).copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Space(height: 16),
                                _weatherSummary(weather),
                              ],
                            ),
                          ),
                          const Space(height: 16),
                          WeatherDetailsWidget(
                            currentWeather: weather.current,
                            cimage: weather.currentWeatherBgImage,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                panelBuilder: (control) {
                  return ClipPath(
                    clipBehavior: const ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ).clipBehavior,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(35.0),
                        topRight: Radius.circular(35.0),
                      ),
                      child: _weatherForecastPanel(weather),
                    ),
                  );
                },
              );
            }
            if (state is HomeFailed) {
              return SomethingWentWrong(message: state.error);
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  Widget _weatherSummary(WeatherData weather) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 30,
        vertical: 11,
      ),
      decoration: BoxDecoration(
        color: AppColors.lightBackgroundColor.withOpacity(0.7),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Text(
        weather.current.weather.first.main,
        style: titleTextStyle(fontSize: 16),
      ),
    );
  }

  Widget _weatherForecastPanel(WeatherData weather) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25.0),
            topRight: Radius.circular(25.0),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 15.0,
                ),
                const Icon(
                  Icons.linear_scale,
                  color: Colors.grey,
                ),
                Text(
                  "Weather Today",
                  style: subTitleTextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Space(height: 12),
                HourlyWeatherWidget(
                  hourWeather: weather.hourly,
                ),
                DailyWeatherWidget(
                  dailyWeather: weather.daily,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
