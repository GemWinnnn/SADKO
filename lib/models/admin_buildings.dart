import 'package:equatable/equatable.dart';

class AdminBuildings extends Equatable {
  final String name;
  final Map<String, dynamic> featuredImage;
  final Map<String, dynamic> createdBy;

  AdminBuildings({this.name, this.featuredImage, this.createdBy});

  AdminBuildings.fromJson(Map<String, dynamic> json)
      : name = json['Name'],
        featuredImage = json['FeaturedImage'],
        createdBy = json['created_by'];

  @override
  List<Object> get props => [name, featuredImage, createdBy];
}
