import 'dart:async';
import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:wvsu_tour_app/config/app.dart';

import 'package:wvsu_tour_app/models/models.dart';

class MessagesApiClient {
  static const baseUrl = apiUrl;
  static const endpoint = 'messages';
  final http.Client httpClient;

  MessagesApiClient({@required this.httpClient}) : assert(httpClient != null);

  Future<List> fetchMessages() async {
    final url = '$baseUrl/$endpoint';
    final response = await this.httpClient.get(url).catchError((onError) {
      print(onError);
    });

    if (response.statusCode != 200) {
      print("Error fetching data");
    }

    final json = jsonDecode(response.body);

    List<Messages> _messagesList = [];

    for (var item in json) {
      Messages announcement = Messages(
          messageBody: item['MessageBody'],
          createdBy: item['created_by'],
          featuredImage: item['FeaturedImage'],
          name: item['Name']);
      _messagesList.add(announcement);
    }

    return _messagesList;
  }
}
