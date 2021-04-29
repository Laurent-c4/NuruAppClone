import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:nuru_clone_app/model/post.dart';
import 'package:nuru_clone_app/model/post_media.dart';

class PostProvider extends ChangeNotifier {
  Post post = new Post(postTitle: "", postDescription: "", postMediaList: []);

  String postTitle = "";
  String postDescription = "";
  List<PostMedia> postMediaList = [];

  void setPostTitle(String title) {
    postTitle = title;
    print(postTitle);
    notifyListeners();
  }

  void setPostDescription(String description) {
    postDescription = description;
    print(postDescription);
    notifyListeners();
  }

  void addMediaToPost(PostMedia postMedia) {
    postMediaList.add(postMedia);
    notifyListeners();
  }

  void removeMediaFromPost(PostMedia postMedia) {
    postMediaList.remove(postMedia);
    notifyListeners();
  }

  void removeMediaAt(int index) {
    postMediaList.removeAt(index);
    notifyListeners();
  }

  void removeAllMediaFromPost() {
    postMediaList.clear();
    notifyListeners();
  }

  void resetPost() {
    postTitle = "";
    print(postTitle);
    postDescription = "";
    print(postDescription);
    postMediaList.clear();
    notifyListeners();
  }
}
