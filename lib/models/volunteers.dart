import 'package:equatable/equatable.dart';

class Volunteers extends Equatable {
  final String name;
  final Map<String, dynamic> profileImage;
  final Map<String, dynamic> createdBy;
  final String description;

  Volunteers({this.name, this.profileImage, this.createdBy, this.description});

  Volunteers.fromJson(Map<String, dynamic> json)
      : name = json['Name'],
        profileImage = json['ProfileImage'],
        createdBy = json['created_by'],
        description = json['Description'];

  @override
  List<Object> get props => [name, createdBy, profileImage, description];
}
