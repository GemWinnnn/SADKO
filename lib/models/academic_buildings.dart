import 'package:equatable/equatable.dart';

class AcademicBuildings extends Equatable {
  final String name;
  final Map<String, dynamic> featuredImage;
  final Map<String, dynamic> createdBy;

  AcademicBuildings({this.name, this.featuredImage, this.createdBy});

  AcademicBuildings.fromJson(Map<String, dynamic> json)
      : name = json['Name'],
        featuredImage = json['FeaturedImage'],
        createdBy = json['created_by'];

  @override
  List<Object> get props => [name, featuredImage, createdBy];
}
