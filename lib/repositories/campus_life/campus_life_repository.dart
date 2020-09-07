import 'dart:async';

import 'package:meta/meta.dart';
import 'package:wvsu_tour_app/repositories/campus_life/campus_life_api.dart';

class CampusLifeRepository {
  final CampusLifeApiClient apiClient;

  CampusLifeRepository({@required this.apiClient}) : assert(apiClient != null);

  Future<List> getData() async {
    return apiClient.fetchCampusLife();
  }
}
