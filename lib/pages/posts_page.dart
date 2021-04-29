import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nuru_clone_app/data.dart';
import 'package:nuru_clone_app/helper/database_helper.dart';
import 'package:nuru_clone_app/model/post.dart';
import 'package:nuru_clone_app/widgets/post_item.dart';

class PostsPage extends StatelessWidget {
  PostsPage({Key key}) : super(key: key);

  Widget postsFromDB() {
    return FutureBuilder(
      builder: (context, posts) {
        if (!posts.hasData) {
          //print('project snapshot data is: ${projectSnap.data}');
          return Container();
        }
        return ListView.builder(
          itemCount: posts.data != null ? posts.data.length : 0,
          itemBuilder: (context, index) {
            Post post = Post(
                id: posts.data[index]['postID'],
                postTitle: posts.data[index]['title'],
                postDescription: posts.data[index]['description']);
            return Dismissible(
                key: UniqueKey(),
                background: Container(
                  color: Colors.red,
                ),
                onDismissed: (direction) {
                  DatabaseHelper.instance.deletePost(post.id);
                },
                child: PostItem(post));
          },
        );
      },
      future: DatabaseHelper.instance.getAllPosts(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final title = 'Long List';

    return postsFromDB();

    // return ListView.builder(
    //   itemCount: items != null ? items.length : 0,
    //   itemBuilder: (context, index) {
    //     return PostItem(items[index]);
    //   },
    // );
  }
}
