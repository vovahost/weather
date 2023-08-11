import 'package:weather/domain/location/model/location_info.dart';

abstract class LocationRepository {
  Future<LocationInfo?> getLocationByCity({
    required String city,
    required String country,
  });
}
