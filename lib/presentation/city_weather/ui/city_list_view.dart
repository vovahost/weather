import 'package:flutter/material.dart';
import 'package:weather/presentation/shared/resources/uk_cities.dart';
import 'package:weather/presentation/shared/utils/utils.dart';

class CityListView extends StatelessWidget {
  const CityListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      itemBuilder: (context, index) {
        final city = ukCities[index];
        return Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              city,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return const Space(height: 0);
      },
      itemCount: ukCities.length,
    );
  }
}
