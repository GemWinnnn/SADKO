import 'dart:async';

import 'package:meta/meta.dart';
import 'package:wvsu_tour_app/repositories/admin_buildings/admin_buildings_api.dart';

class AdminBuildingsRepository {
  final AdminBuildingsApiClient apiClient;

  AdminBuildingsRepository({@required this.apiClient})
      : assert(apiClient != null);

  Future<List> getData() async {
    return apiClient.fetchAdminBuildings();
  }
}
