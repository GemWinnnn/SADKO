import 'package:equatable/equatable.dart';

class Colleges extends Equatable {
  final String campus;
  final List<Map<String, dynamic>> photos;
  final String longDescription;
  final Map<String, dynamic> createdBy;
  final Map<String, dynamic> featuredImage;
  final Map<String, dynamic> logo;

  Colleges(
      {this.campus,
      this.featuredImage,
      this.createdBy,
      this.logo,
      this.longDescription,
      this.photos});

  Colleges.fromJson(Map<String, dynamic> json)
      : campus = json['Campus'],
        photos = json['Photos'],
        featuredImage = json['FeaturedImage'],
        logo = json['Logo'],
        longDescription = json['LongDescription'],
        createdBy = json['created_by'];

  @override
  List<Object> get props =>
      [campus, featuredImage, createdBy, logo, longDescription, photos];
}
