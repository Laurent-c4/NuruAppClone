import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nuru_clone_app/data.dart';
import 'package:nuru_clone_app/model/post.dart';
import 'package:nuru_clone_app/widgets/post_item.dart';

class PostsPage extends StatelessWidget {
  List<Post> items = posts;

  PostsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final title = 'Long List';

    return ListView.builder(
      itemCount: items != null ? items.length : 0,
      itemBuilder: (context, index) {
        return PostItem(items[index]);
      },
    );
  }
}
