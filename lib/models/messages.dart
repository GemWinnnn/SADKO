import 'package:equatable/equatable.dart';

class Messages extends Equatable {
  final String name;
  final String messageBody;
  final Map<String, dynamic> featuredImage;
  final Map<String, dynamic> createdBy;

  Messages({this.name, this.messageBody, this.featuredImage, this.createdBy});

  Messages.fromJson(Map<String, dynamic> json)
      : messageBody = json['MessageBody'],
        name = json['Name'],
        featuredImage = json['FeaturedImage'],
        createdBy = json['created_by'];

  @override
  List<Object> get props => [name, messageBody, featuredImage, createdBy];
}
