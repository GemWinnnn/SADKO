import 'dart:async';

import 'package:meta/meta.dart';
import 'package:wvsu_tour_app/repositories/colleges/colleges_api.dart';

class CollegesRepository {
  final CollegesApiClient apiClient;

  CollegesRepository({@required this.apiClient}) : assert(apiClient != null);

  Future<List> getData() async {
    return apiClient.fetchColleges();
  }
}
