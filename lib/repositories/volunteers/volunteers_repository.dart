import 'dart:async';

import 'package:meta/meta.dart';
import 'package:wvsu_tour_app/repositories/volunteers/volunteers_api.dart';

class VolunteersRepository {
  final VolunteersApiClient apiClient;

  VolunteersRepository({@required this.apiClient}) : assert(apiClient != null);

  Future<List> getData() async {
    return apiClient.fetchVolunteers();
  }
}
