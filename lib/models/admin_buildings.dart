import 'package:equatable/equatable.dart';

class AdminBuildings extends Equatable {
  final String name;
  final Map<String, dynamic> featuredImage;
  final Map<String, dynamic> createdBy;
  final String fullDescription;
  AdminBuildings(
      {this.name, this.featuredImage, this.createdBy, this.fullDescription});

  AdminBuildings.fromJson(Map<String, dynamic> json)
      : name = json['Name'],
        featuredImage = json['FeaturedImage'],
        fullDescription = json['FullDescription'],
        createdBy = json['created_by'];

  @override
  List<Object> get props => [name, featuredImage, createdBy, fullDescription];
}
