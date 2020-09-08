import 'dart:async';
import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:wvsu_tour_app/config/app.dart';

import 'package:wvsu_tour_app/models/models.dart';

class AcademicBuildingsApiClient {
  static const baseUrl = apiUrl;
  static const endpoint = 'academic-buildings';
  final http.Client httpClient;

  AcademicBuildingsApiClient({@required this.httpClient})
      : assert(httpClient != null);

  Future<List> fetchAcademicBuildings() async {
    final url = '$baseUrl/$endpoint';
    final response = await this.httpClient.get(url).catchError((onError) {
      print(onError);
    });

    if (response.statusCode != 200) {
      print("Error fetching data");
    }

    final json = jsonDecode(response.body);

    List<AcademicBuildings> _messagesList = [];

    for (var item in json) {
      AcademicBuildings destructured = AcademicBuildings(
          createdBy: item['created_by'],
          featuredImage: item['FeaturedImage'],
          name: item['Name']);
      _messagesList.add(destructured);
    }

    return _messagesList;
  }
}
