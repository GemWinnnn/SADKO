import 'dart:async';
import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:wvsu_tour_app/config/app.dart';

import 'package:wvsu_tour_app/models/models.dart';

class CollegesApiClient {
  static const baseUrl = apiUrl;
  static const endpoint = 'colleges';
  final http.Client httpClient;

  CollegesApiClient({@required this.httpClient}) : assert(httpClient != null);

  Future<List> fetchColleges() async {
    final url = '$baseUrl/$endpoint';
    final response = await this.httpClient.get(url).catchError((onError) {
      print(onError);
    });

    if (response.statusCode != 200) {
      print("Error fetching data");
    }

    final json = jsonDecode(response.body);

    List<Colleges> _messagesList = [];

    for (var item in json) {
      Colleges destructured = Colleges(
          createdBy: item['created_by'],
          featuredImage: item['FeaturedImage'],
          campus: item['Campus'],
          logo: item['Logo'],
          name: item['Name'],
          shortDescription: item['shortDescription'],
          longDescription: item['LongDescription'],
          photos: item['Photos']);
      _messagesList.add(destructured);
    }

    return _messagesList;
  }
}
