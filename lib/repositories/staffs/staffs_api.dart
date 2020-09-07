import 'dart:async';
import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:wvsu_tour_app/config/app.dart';

import 'package:wvsu_tour_app/models/models.dart';

class StaffsApiClient {
  static const baseUrl = apiUrl;
  static const endpoint = 'office-staffs';
  final http.Client httpClient;

  StaffsApiClient({@required this.httpClient}) : assert(httpClient != null);

  Future<List> fetchStaffs() async {
    final url = '$baseUrl/$endpoint';
    final response = await this.httpClient.get(url).catchError((onError) {
      print(onError);
    });

    if (response.statusCode != 200) {
      print("Error fetching data");
    }

    final json = jsonDecode(response.body);

    List<Staffs> _staffsList = [];

    for (var item in json) {
      Staffs announcement = Staffs(
          campus: item['Campus'],
          createdBy: item['created_by'],
          office: item['Office'],
          profilePicture: item['ProfilePicture'],
          description: item['Description'],
          name: item['Name']);
      _staffsList.add(announcement);
    }

    return _staffsList;
  }
}
