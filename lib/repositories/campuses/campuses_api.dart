import 'dart:async';
import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:wvsu_tour_app/config/app.dart';

import 'package:wvsu_tour_app/models/models.dart';

class CampusesApiClient {
  static const baseUrl = apiUrl;
  static const endpoint = 'campuses';
  final http.Client httpClient;

  CampusesApiClient({@required this.httpClient}) : assert(httpClient != null);

  Future<List> fetchCampuses() async {
    final url = '$baseUrl/$endpoint';
    final response = await this.httpClient.get(url).catchError((onError) {
      print(onError);
    });

    if (response.statusCode != 200) {
      print("Error fetching data");
    }

    final json = jsonDecode(response.body);

    List<Campuses> _messagesList = [];

    for (var item in json) {
      Campuses destructured = Campuses(
          createdBy: item['created_by'],
          featuredImage: item['FeaturedImage'],
          logo: item['Logo'],
          fullDescription: item['FullDescription'],
          name: item['Name'],
          shortDescription: item['ShortDescription']);
      _messagesList.add(destructured);
    }

    return _messagesList;
  }
}
