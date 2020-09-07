import 'dart:async';

import 'package:meta/meta.dart';
import 'package:wvsu_tour_app/repositories/organizations/organizations_api.dart';

class OrganizationsRepository {
  final OrganizationsApiClient apiClient;

  OrganizationsRepository({@required this.apiClient})
      : assert(apiClient != null);

  Future<List> getData() async {
    return apiClient.fetchOrganizations();
  }
}
