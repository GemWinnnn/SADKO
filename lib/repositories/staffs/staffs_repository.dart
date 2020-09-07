import 'dart:async';

import 'package:meta/meta.dart';
import 'package:wvsu_tour_app/repositories/staffs/staffs_api.dart';

class StaffsRepository {
  final StaffsApiClient apiClient;

  StaffsRepository({@required this.apiClient}) : assert(apiClient != null);

  Future<List> getData() async {
    return apiClient.fetchStaffs();
  }
}
