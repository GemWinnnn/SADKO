import 'dart:async';
import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:wvsu_tour_app/config/app.dart';

import 'package:wvsu_tour_app/models/models.dart';

class OrganizationsApiClient {
  static const baseUrl = apiUrl;
  static const endpoint = 'organizations';
  final http.Client httpClient;

  OrganizationsApiClient({@required this.httpClient})
      : assert(httpClient != null);

  Future<List> fetchOrganizations() async {
    final url = '$baseUrl/$endpoint';
    final response = await this.httpClient.get(url).catchError((onError) {
      print(onError);
    });

    if (response.statusCode != 200) {
      print("Error fetching data");
    }

    final json = jsonDecode(response.body);

    List<Organizations> _organizationsList = [];

    for (var item in json) {
      Organizations announcement = Organizations(
          createdBy: item['created_by'],
          logo: item['Logo'],
          description: item['Description'],
          name: item['Name']);
      _organizationsList.add(announcement);
    }

    return _organizationsList;
  }
}
