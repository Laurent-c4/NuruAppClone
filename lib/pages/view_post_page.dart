import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:nuru_clone_app/helper/database_helper.dart';
import 'package:nuru_clone_app/model/post.dart';
import 'package:nuru_clone_app/provider/post_provider.dart';
import 'package:nuru_clone_app/provider/theme_provider.dart';
import 'package:nuru_clone_app/widgets/image_selector.dart';
import 'package:nuru_clone_app/widgets/simple_recorder.dart';
import 'package:nuru_clone_app/widgets/snackbar.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../model/post_media.dart';
import '../model/post_media.dart';
import '../provider/post_provider.dart';

class ViewPostPage extends StatefulWidget {
  final Post post;
  final List<PostMedia> postMediaList;

  const ViewPostPage({Key key, this.post, this.postMediaList})
      : super(key: key);

  @override
  _ViewPostPageState createState() => _ViewPostPageState();
}

class _ViewPostPageState extends State<ViewPostPage> {
  TextEditingController postTitleController = TextEditingController();
  TextEditingController postDescriptionController = TextEditingController();
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            child: SingleChildScrollView(
              child: Consumer<PostProvider>(
                  builder: (context, postProvider, child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    widget.postMediaList.isNotEmpty
                        ? Column(
                            // margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                            children: [
                                CarouselSlider(
                                  options: CarouselOptions(
                                      aspectRatio: 16.9,
                                      enlargeCenterPage: true,
                                      enableInfiniteScroll: true,
                                      scrollDirection: Axis.horizontal,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              3 /
                                              8,
                                      initialPage: 0,
                                      autoPlay: true,
                                      onPageChanged: (index, reason) {
                                        setState(() {
                                          _current = index;
                                        });
                                      }),
                                  items: widget.postMediaList
                                      .map((e) => Container(
                                              child: InkWell(
                                            onTap: () {
                                              CustomSnackBar(
                                                  context,
                                                  Text(
                                                    "Video Playback Coming soon",
                                                    style: TextStyle(
                                                      color: Provider.of<ThemeProvider>(
                                                                      context,
                                                                      listen:
                                                                          false)
                                                                  .themeMode ==
                                                              ThemeMode.dark
                                                          ? Colors.black
                                                          : Colors.white,
                                                    ),
                                                  ));
                                            },
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Semantics(
                                                    child: e.mediaType
                                                                .toLowerCase() ==
                                                            "audio"
                                                        ? Image.asset(
                                                            'assets/img/audio_placeholder.png',
                                                            fit: BoxFit.cover,
                                                            height: 250)
                                                        : e.mediaType
                                                                    .toLowerCase() ==
                                                                "video"
                                                            ? Image.asset(
                                                                'assets/img/video_placeholder.png',
                                                                fit: BoxFit
                                                                    .cover,
                                                                height: 250)
                                                            : Image.file(
                                                                File(e
                                                                    .mediaPath),
                                                                fit: BoxFit
                                                                    .cover,
                                                                height: 250,
                                                              ),
                                                    label:
                                                        'image_picker_example_picked_image'),
                                                Text(e.mediaType)
                                              ],
                                            ),
                                          )))
                                      .toList(),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: widget.postMediaList.map((url) {
                                    int index =
                                        widget.postMediaList.indexOf(url);
                                    return Container(
                                      width: 8.0,
                                      height: 8.0,
                                      margin: EdgeInsets.symmetric(
                                          vertical: 10.0, horizontal: 2.0),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: _current == index
                                            ? Theme.of(context).accentColor
                                            : Color.fromRGBO(0, 0, 0, 0.4),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ])
                        : Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width,
                            child: Text(
                              'This post does not contain media',
                            ),
                          ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(widget.post.postTitle,
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 20.0)),
                    SizedBox(
                      height: 20,
                    ),
                    Text(widget.post.postDescription),
                  ],
                );
              }),
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Semantics(
            label: 'edit post',
            child: FloatingActionButton(
              backgroundColor: Theme.of(context).accentColor,
              onPressed: () {
                // _navigateAndDisplaySelection(context, ImageSelector());
                CustomSnackBar(
                    context,
                    Text(
                      "Post Editing Coming soon",
                      style: TextStyle(
                        color:
                            Provider.of<ThemeProvider>(context, listen: false)
                                        .themeMode ==
                                    ThemeMode.dark
                                ? Colors.black
                                : Colors.white,
                      ),
                    ));
              },
              heroTag: 'edit',
              tooltip: 'Edit Post',
              child: const Icon(Icons.edit),
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

  if (result != null) {
    Provider.of<PostProvider>(context, listen: false).addMediaToPost(result);
  }
}

_removeAlertDialog(BuildContext context, int index) {
  // set up the button
  Widget cancelButton = TextButton(
    child: Text("CANCEL"),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  // set up the button
  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () {
      Provider.of<PostProvider>(context, listen: false).removeMediaAt(index);
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Delete"),
    content: Text("Are you sure?"),
    actions: [
      cancelButton,
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
