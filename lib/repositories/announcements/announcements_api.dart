import 'dart:convert';
import 'dart:async';

import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import 'package:wvsu_tour_app/models/models.dart';

class AnnouncementsApiClient {
  static const baseUrl = 'http://128.199.253.64:1337';
  static const endpoint = 'announcements';
  final http.Client httpClient;

  AnnouncementsApiClient({@required this.httpClient})
      : assert(httpClient != null);

  Future<Announcements> fetchAnnouncements() async {
    final url = '$baseUrl/$endpoint';
    final response = await this.httpClient.get(url);

    if (response.statusCode != 200) {
      throw Exception('error getting weather for location');
    }

    final json = jsonDecode(response.body);
    return Announcements.fromJson(json);
  }
}
