import 'package:equatable/equatable.dart';

class Staffs extends Equatable {
  final String name;
  final String office;
  final String description;
  final Map<String, dynamic> profilePicture;
  final Map<String, dynamic> createdBy;
  final String campus;

  Staffs(
      {this.name,
      this.office,
      this.campus,
      this.profilePicture,
      this.createdBy,
      this.description});

  Staffs.fromJson(Map<String, dynamic> json)
      : office = json['Office'],
        name = json['Name'],
        campus = json['Campus'],
        profilePicture = json['ProfilePicture'],
        createdBy = json['created_by'],
        description = json['Description'];

  @override
  List<Object> get props =>
      [name, office, campus, profilePicture, createdBy, description];
}
