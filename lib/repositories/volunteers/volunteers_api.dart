import 'dart:async';
import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:wvsu_tour_app/config/app.dart';

import 'package:wvsu_tour_app/models/models.dart';

class VolunteersApiClient {
  static const baseUrl = apiUrl;
  static const endpoint = 'volunteers';
  final http.Client httpClient;

  VolunteersApiClient({@required this.httpClient}) : assert(httpClient != null);

  Future<List> fetchVolunteers() async {
    final url = '$baseUrl/$endpoint';
    final response = await this.httpClient.get(url).catchError((onError) {
      print(onError);
    });

    if (response.statusCode != 200) {
      print("Error fetching data");
    }

    final json = jsonDecode(response.body);

    List<Volunteers> _volunteersList = [];

    for (var item in json) {
      Volunteers destructured = Volunteers(
          createdBy: item['created_by'],
          profileImage: item['ProfileImage'],
          description: item['Description'],
          name: item['Name']);
      _volunteersList.add(destructured);
    }

    return _volunteersList;
  }
}
