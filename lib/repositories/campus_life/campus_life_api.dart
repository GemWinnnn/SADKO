import 'dart:async';
import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:wvsu_tour_app/config/app.dart';

import 'package:wvsu_tour_app/models/models.dart';

class CampusLifeApiClient {
  static const baseUrl = apiUrl;
  static const endpoint = 'campus-lives';
  final http.Client httpClient;

  CampusLifeApiClient({@required this.httpClient}) : assert(httpClient != null);

  Future<List> fetchCampusLife() async {
    final url = '$baseUrl/$endpoint';
    final response = await this.httpClient.get(url).catchError((onError) {
      print(onError);
    });

    if (response.statusCode != 200) {
      print("Error fetching data");
    }

    final json = jsonDecode(response.body);

    List<CampusLife> _campus_lifeList = [];

    for (var item in json) {
      CampusLife destructured = CampusLife(
          createdBy: item['created_by'],
          image: item['Image'],
          shortDescription: item['ShortDescription']);
      _campus_lifeList.add(destructured);
    }

    return _campus_lifeList;
  }
}
