import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/presentation/city_weather/bloc/city_weather_bloc.dart';
import 'package:weather/presentation/city_weather/ui/city_list_view.dart';
import 'package:weather/presentation/shared/resources/app_colors.dart';
import 'package:weather/presentation/shared/resources/app_images.dart';
import 'package:weather/presentation/shared/resources/app_text_styles.dart';
import 'package:weather/presentation/shared/utils/utils.dart';
import 'package:weather/presentation/shared/widgets/loading_indicator.dart';
import 'package:weather/presentation/shared/widgets/weather_detail_widget.dart';

class CityWeatherPage extends StatefulWidget {
  const CityWeatherPage({super.key});

  @override
  State<CityWeatherPage> createState() => _CityWeatherPageState();
}

class _CityWeatherPageState extends State<CityWeatherPage> {
  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => CityWeatherBloc(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            body: BlocListener<CityWeatherBloc, CityWeatherState>(
              listener: (context, state) {
                if (state is CityWeatherFailed) {
                  showUnknownErrorSnackBar(context);
                }
              },
              child: BlocBuilder<CityWeatherBloc, CityWeatherState>(
                builder: (context, state) {
                  if (state is CityWeatherInitial ||
                      _searchController.text.isEmpty) {
                    return cityWeatherInitial(size, context);
                  }
                  if (state is CityWeatherLoading) {
                    return const LoadingIndicator();
                  }
                  if (state is CityWeatherSuccess) {
                    return cityWeatherSuccess(state, size, context);
                  }
                  if (state is CityWeatherFailed) {
                    return _cityWeatherError(size, context);
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Widget cityWeatherInitial(Size size, BuildContext context) {
    return Container(
      height: size.height,
      alignment: Alignment.center,
      child: Column(
        children: [
          _searchBar(size, context),
          const Space(height: 8),
          const Expanded(
            child: CityListView(),
          ),
        ],
      ),
    );
  }

  Widget _searchBar(Size size, BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 40, left: 16, right: 16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
            ),
          ]),
      width: size.width,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _searchController,
              style: titleTextStyle(fontSize: 18),
              onSubmitted: (value) {
                BlocProvider.of<CityWeatherBloc>(context)
                    .add(SearchCityWeather(value));
              },
              decoration: InputDecoration(
                hintText: 'Type a city',
                hintStyle: subTitleTextStyle(fontSize: 18),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              ),
            ),
          ),
          IconButton(
            key: const ValueKey('search'),
            onPressed: () {
              BlocProvider.of<CityWeatherBloc>(context)
                  .add(SearchCityWeather(_searchController.text));
            },
            icon: Icon(
              Icons.search,
              size: 28,
              color: AppColors.iconColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget cityWeatherSuccess(
    CityWeatherSuccess state,
    Size size,
    BuildContext context,
  ) {
    return Stack(
      children: [
        Image.asset(
          state.weather.currentWeatherBgImage,
          fit: BoxFit.cover,
          height: size.height,
          width: size.width,
        ),
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SizedBox(
            height: size.height,
            width: size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 100.0,
                ),
                Image.asset(
                  AppImages.getAsset(state.weather.weather.first.icon),
                  height: size.height * 0.18,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  decoration: BoxDecoration(
                    color: AppColors.lightBackgroundColor,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Text(
                    state.weather.weather.first.main,
                    style: titleTextStyle(fontSize: 16),
                  ),
                ),
                const Space(height: 10),
                Text(
                  "${state.weather.name}, ${state.weather.country}",
                  style: titleTextStyle(fontSize: 22),
                ),
                const Space(height: 10),
                Text(
                  '${state.weather.temp}° C',
                  style: titleTextStyle(fontSize: 50),
                ),
                const Space(height: 8),
                Text(
                  '${state.weather.tempMax}° C / ${state.weather.tempMin}° C',
                  style: subTitleTextStyle(fontSize: 18),
                ),
                Expanded(
                  child: GridView(
                    shrinkWrap: true,
                    primary: false,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 2.7, crossAxisCount: 2),
                    children: [
                      HeadingDetailWidget(
                          cimage: 'assets/images/cold_mode.jpg',
                          title: "Humidity",
                          value: '${state.weather.humidity}%'),
                      HeadingDetailWidget(
                          cimage: 'assets/images/cold_mode.jpg',
                          title: "Wind Speed",
                          value: '${state.weather.wind} m/s'),
                      HeadingDetailWidget(
                          cimage: 'assets/images/cold_mode.jpg',
                          title: "Pressure",
                          value: '${state.weather.pressure} hPa'),
                      HeadingDetailWidget(
                          cimage: 'assets/images/cold_mode.jpg',
                          title: "Visibility",
                          value: '${state.weather.visibility / 1000} km'),
                      HeadingDetailWidget(
                          cimage: 'assets/images/cold_mode.jpg',
                          title: "Cloudiness",
                          value: '${state.weather.clouds}%'),
                      HeadingDetailWidget(
                          cimage: 'assets/images/cold_mode.jpg',
                          title: "Feels Like",
                          value: '${state.weather.feelsLike}'),
                      HeadingDetailWidget(
                          cimage: 'assets/images/cold_mode.jpg',
                          title: "Sunrise",
                          value: getTimeInHHMM(state.weather.sunrise)),
                      HeadingDetailWidget(
                          cimage: 'assets/images/cold_mode.jpg',
                          title: "Sunset",
                          value: getTimeInHHMM(state.weather.sunset)),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        _searchBar(size, context),
      ],
    );
  }

  Widget _cityWeatherError(Size size, BuildContext context) {
    return Stack(
      children: [
        const SomethingWentWrong(),
        _searchBar(size, context),
      ],
    );
  }
}
