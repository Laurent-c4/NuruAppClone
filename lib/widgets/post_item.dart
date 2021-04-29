import 'package:flutter/material.dart';
import 'package:nuru_clone_app/helper/database_helper.dart';
import 'package:nuru_clone_app/model/post.dart';
import 'package:nuru_clone_app/pages/view_post_page.dart';

import '../model/post_media.dart';
import '../model/post_media.dart';

class PostItem extends StatelessWidget {
  final Post post;

  PostItem(this.post);

  Widget postMediaFromDB() {
    return FutureBuilder(
      builder: (context, postMedia) {
        if (!postMedia.hasData) {
          //print('project snapshot data is: ${projectSnap.data}');
          return Container();
        }
        return Container(
          margin: new EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: new Material(
            elevation: 30.0,
            shadowColor: Colors.black54,
            color: Theme.of(context).disabledColor,
            borderRadius: new BorderRadius.circular(6.0),
            child: new Padding(
              padding: new EdgeInsets.symmetric(vertical: 6.0),
              child: new ListTile(
                onTap: () {
                  List<PostMedia> postMediaList = [];

                  for (var datum in postMedia.data) {
                    postMediaList.add(PostMedia(mediaType: datum['mediaType'],mediaPath: datum['mediaPath']));
                  }


                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ViewPostPage(
                              post: post,
                              postMediaList: postMediaList,
                            )),
                  );
                },
                leading: new Image.asset('assets/img/login_logo.png'),
                title: new Text(post.postTitle,
                    style: new TextStyle(
                        fontWeight: FontWeight.w700, fontSize: 20.0)),
                subtitle: new Material(
                  // color: Theme.of(context).accentColor,
                  borderRadius: new BorderRadius.circular(8.0),
                  child: new Container(
                    margin: new EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 4.0),
                    child: new Text(post.postDescription),
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(postMedia.data.length.toString()),
                    new IconButton(
                      onPressed: () {},
                      icon: new Icon(Icons.file_present,
                          color: Theme.of(context).accentColor),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      future: DatabaseHelper.instance.getPostMediaForPost(post.id),
    );
  }

  @override
  Widget build(BuildContext context) {
    return postMediaFromDB();
  }
}
