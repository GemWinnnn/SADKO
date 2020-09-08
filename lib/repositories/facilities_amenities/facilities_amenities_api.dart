import 'dart:async';
import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:wvsu_tour_app/config/app.dart';
import 'package:wvsu_tour_app/models/facilities_amenities.dart';

import 'package:wvsu_tour_app/models/models.dart';

class FacilitiesAmenitiesApiClient {
  static const baseUrl = apiUrl;
  static const endpoint = 'facilities-and-amenities';
  final http.Client httpClient;

  FacilitiesAmenitiesApiClient({@required this.httpClient})
      : assert(httpClient != null);

  Future<List> fetchFacilitiesAmenities() async {
    final url = '$baseUrl/$endpoint';
    final response = await this.httpClient.get(url).catchError((onError) {
      print(onError);
    });

    if (response.statusCode != 200) {
      print("Error fetching data");
    }

    final json = jsonDecode(response.body);

    List<FacilitiesAmenities> _facilitiesAmenitiesList = [];

    for (var item in json) {
      FacilitiesAmenities destructured = FacilitiesAmenities(
          shortDescription: item['ShortDescription'],
          createdBy: item['created_by'],
          featuredImage: item['FeaturedImage'],
          name: item['Name']);
      _facilitiesAmenitiesList.add(destructured);
    }

    return _facilitiesAmenitiesList;
  }
}
