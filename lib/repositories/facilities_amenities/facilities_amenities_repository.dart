import 'dart:async';

import 'package:meta/meta.dart';
import 'package:wvsu_tour_app/repositories/facilities_amenities/facilities_amenities_api.dart';

class FacilitiesAmenitiesRepository {
  final FacilitiesAmenitiesApiClient apiClient;

  FacilitiesAmenitiesRepository({@required this.apiClient})
      : assert(apiClient != null);

  Future<List> getData() async {
    return apiClient.fetchFacilitiesAmenities();
  }
}
