import 'package:nuru_clone_app/model/post_media.dart';

class Post
{
  String postTitle;
  String postDescription;
  List<PostMedia> postMediaList;

  String get getPostTitle => postTitle;
  String get getPostDescription => postDescription;
  List<PostMedia> get getPostMedia => postMediaList;

  Post({this.postTitle, this.postDescription, this.postMediaList});



}