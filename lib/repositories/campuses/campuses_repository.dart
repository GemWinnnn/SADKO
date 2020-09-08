import 'dart:async';

import 'package:meta/meta.dart';
import 'package:wvsu_tour_app/repositories/campuses/campuses_api.dart';

class CampusesRepository {
  final CampusesApiClient apiClient;

  CampusesRepository({@required this.apiClient}) : assert(apiClient != null);

  Future<List> getData() async {
    return apiClient.fetchCampuses();
  }
}
