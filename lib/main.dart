import 'package:flutter/material.dart';
import 'package:weather/presentation/city_weather/ui/city_weather_page.dart';
import 'package:weather/presentation/home/ui/home_page.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatefulWidget {
  const WeatherApp({super.key});

  @override
  State<WeatherApp> createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Weather App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        body: _getPage(_selectedIndex),
        bottomNavigationBar: _bottomNavBar,
      ),
    );
  }

  BottomNavigationBar get _bottomNavBar {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Weather',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.business),
          label: 'Cities',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Search',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.cyan[800],
      onTap: _onItemTapped,
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _getPage(int selectedIndex) {
    switch (selectedIndex) {
      case 0:
        return const HomePage();
      case 1:
        return Text('$selectedIndex');
      case 2:
        return const CityWeatherPage();
      default:
        throw ArgumentError('Invalid page $selectedIndex');
    }
  }
}
