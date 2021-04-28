import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:nuru_clone_app/model/post.dart';
import 'package:nuru_clone_app/provider/post_provider.dart';
import 'package:nuru_clone_app/provider/theme_provider.dart';
import 'package:nuru_clone_app/widgets/image_picker.dart';
import 'package:nuru_clone_app/widgets/simple_recorder.dart';
import 'package:nuru_clone_app/widgets/snackbar.dart';
import 'package:provider/provider.dart';

class AddPostPage extends StatefulWidget {
  @override
  _AddPostPageState createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  TextEditingController postTitleController = TextEditingController();
  TextEditingController postDescriptionController = TextEditingController();

  // Future<void> _pickImage(ImageSource source) async {
  //   final selected = await ImagePicker().getImage(source: source);
  //   setState(() {
  //     _imageFile = File(selected.path);
  //   });
  // }

  void _clear() {
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery
            .of(context)
            .size
            .width,
        height: MediaQuery
            .of(context)
            .size
            .height,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
          child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Consumer<PostProvider>(
                  builder: (context, postProvider, child) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                      ListView(
                      shrinkWrap: true,
                      children: <Widget>[
                    postProvider.postMediaList.isNotEmpty
                    ? Container(
                      alignment: Alignment.center,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      child: Text(
                        "The " + postProvider.postMediaList.length.toString() + " item(s) will be displayed here... I ran out of time." ,
                      ),
                    )
                        : Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                    'No media added yet',
                    ),
                    ),
                    ],
                    ),
                    Container(
                    child: TextField(
                    onChanged: (String value) {
                    },
                    controller: postTitleController,
                    decoration: InputDecoration(
                    labelText: 'Add a Title',
                    ),
                    ),
                    ),
                    SizedBox(
                    height: 20,
                    ),
                    Container(
                    child: TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    onChanged: (String value) {
                    },
                    controller: postDescriptionController,
                    decoration: InputDecoration(
                    labelText: 'Write a caption',
                    ),
                    ),
                    ),
                    ]
                    ,
                    );
                  })),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Semantics(
            label: 'image_picker_example_from_gallery',
            child: FloatingActionButton(
              onPressed: () {
                _navigateAndDisplaySelection(context, ImageSelector());
              },
              heroTag: 'image0',
              tooltip: 'Pick Image from gallery',
              child: const Icon(Icons.add_a_photo),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: FloatingActionButton(
              onPressed: () {
                _navigateAndDisplaySelection(context, SimpleRecorder());
              },
              heroTag: 'image1',
              tooltip: 'Take a Photo',
              child: const Icon(Icons.record_voice_over),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: FloatingActionButton(
              backgroundColor: Theme
                  .of(context)
                  .primaryColor,
              onPressed: () {
                Provider.of<PostProvider>(context, listen: false)
                    .setPostTitle(postTitleController.text);
                Provider.of<PostProvider>(context, listen: false)
                    .setPostDescription(postDescriptionController.text);

                CustomSnackBar(context,Text("If you allow me, I can complete this awesome app...", style: TextStyle(color: Theme.of(context).primaryColor),));
              },
              heroTag: 'done',
              tooltip: 'Add',
              child: const Icon(Icons.check_outlined),
            ),
          ),
        ],
      ),
    );
  }
}

// A method that launches the SelectionScreen and awaits the result from
// Navigator.pop.
_navigateAndDisplaySelection(BuildContext context, Widget widget) async {
  // Navigator.push returns a Future that completes after calling
  // Navigator.pop on the Selection Screen.
  final result = await Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => widget),
  );

  Provider.of<PostProvider>(context, listen: false)
      .addMediaToPost(result);
}
