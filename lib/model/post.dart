import 'package:nuru_clone_app/model/post_media.dart';

class Post {
  final int id;
  final String postTitle;
  final String postDescription;
  final List<PostMedia> postMediaList;

  String get getPostTitle => postTitle;

  String get getPostDescription => postDescription;

  List<PostMedia> get getPostMedia => postMediaList;

  Post({this.id, this.postTitle, this.postDescription, this.postMediaList});

  //Converts a Post into a Map. The keys must correspond to the names of the
  //columns in the database
  Map<String, dynamic> toMap() {
    return {'postID': id, 'title': postTitle, 'description': postDescription};
  }
}
