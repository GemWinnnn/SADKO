class Announcements {
  final String title;
  final String contents;
  final Map<String, dynamic> featuredImage;
  final Map<String, dynamic> createdBy;

  Announcements(
      {this.title, this.contents, this.featuredImage, this.createdBy});

  Announcements.fromJson(Map<String, dynamic> json)
      : contents = json['Contents'],
        title = json['Title'],
        featuredImage = json['FeaturedImage'],
        createdBy = json['created_by'];

  @override
  List<Object> get props => [title, contents, featuredImage, createdBy];
}
