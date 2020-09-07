import 'dart:async';

import 'package:meta/meta.dart';
import 'package:wvsu_tour_app/repositories/academic_buildings/academic_buildings_api.dart';

class AcademicBuildingsRepository {
  final AcademicBuildingsApiClient apiClient;

  AcademicBuildingsRepository({@required this.apiClient})
      : assert(apiClient != null);

  Future<List> getData() async {
    return apiClient.fetchAcademicBuildings();
  }
}
