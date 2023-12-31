import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:weather/domain/weather/model/weather_forecast.dart';
import 'package:weather/presentation/home/bloc/home_bloc.dart';
import 'package:weather/presentation/shared/extensions/string_extensions.dart';
import 'package:weather/presentation/shared/resources/app_colors.dart';
import 'package:weather/presentation/shared/resources/app_images.dart';
import 'package:weather/presentation/shared/resources/app_text_styles.dart';
import 'package:weather/presentation/shared/utils/utils.dart';
import 'package:weather/presentation/shared/widgets/dialy_weather_widget.dart';
import 'package:weather/presentation/shared/widgets/hourly_weather_widget.dart';
import 'package:weather/presentation/shared/widgets/loading_indicator.dart';
import 'package:weather/presentation/shared/widgets/weather_detail_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PanelController _controller = PanelController();
  double _bottomPanelGradientStep = 0.5;

  @override
  void initState() {
    getCurrentMode();

    super.initState();
  }

  String getCurrentMode() {
    var timeNow = DateTime.now().hour;
    if (timeNow <= 17) {
      return 'night';
    } else {
      return 'day';
    }
  }

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
              showUnknownErrorSnackBar(context);
            }
          },
          builder: (context, state) {
            Widget widget;
            if (state is HomeLoading) {
              widget = const LoadingIndicator();
            } else if (state is HomeSuccess) {
              final weather = state.weatherData;
              widget = _slidingUpPanel(size, weather, state);
            } else if (state is HomeFailed) {
              widget = const SomethingWentWrong();
            } else {
              widget = const SizedBox();
            }
            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 350),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
              child: widget,
            );
          },
        ),
      ),
    );
  }

  Widget _slidingUpPanel(
    Size size,
    WeatherData weather,
    HomeSuccess state,
  ) {
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Space(height: 64),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Text(
                    state.place.toTitleCase(),
                    maxLines: 1,
                    overflow: TextOverflow.fade,
                    softWrap: false,
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
                ),
                const Space(height: 16),
                Container(
                  // width: size.width * 0.6,
                  padding: EdgeInsets.only(
                    left: size.width * 0.08,
                    right: size.width * 0.08,
                    bottom: 20.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
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
                          Image.asset(
                            AppImages.getAsset(weather.current.weather.first.icon),
                            height: size.height * 0.1,
                          ),
                        ],
                      ),
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
      onPanelSlide: (position) {
        setState(() {
          _bottomPanelGradientStep = 0.5 - position * 0.5;
        });
      },
      panelBuilder: (control) {
        return ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(35.0),
            topRight: Radius.circular(35.0),
          ),
          child: _weatherForecastPanel(weather),
        );
      },
    );
  }

  Widget _weatherSummary(WeatherData weather) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 30,
        vertical: 11,
      ),
      decoration: BoxDecoration(
        color: AppColors.lightBackgroundColor.withOpacity(0.4),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Text(
        weather.current.weather.first.main,
        style: titleTextStyle(fontSize: 19),
      ),
    );
  }

  Widget _weatherForecastPanel(WeatherData weather) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.0, _bottomPanelGradientStep],
          colors: [
            Colors.white.withOpacity(0.4),
            Colors.white,
          ],
        ),
      ),
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
                  hourWeatherList: weather.hourly,
                ),
                DailyWeatherWidget(
                  dailyWeather: weather.daily,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
