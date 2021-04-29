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

import '../provider/post_provider.dart';

class AddPostPage extends StatefulWidget {
  @override
  _AddPostPageState createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  TextEditingController postTitleController = TextEditingController();
  TextEditingController postDescriptionController = TextEditingController();
  int _current = 0;

  // Future<void> _pickImage(ImageSource source) async {
  //   final selected = await ImagePicker().getImage(source: source);
  //   setState(() {
  //     _imageFile = File(selected.path);
  //   });
  // }

  void _clear() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
          child: SingleChildScrollView(
            child:
                Consumer<PostProvider>(builder: (context, postProvider, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  postProvider.postMediaList.isNotEmpty
                      ? Column(
                          // margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          children: [
                              CarouselSlider(
                                options: CarouselOptions(
                                    aspectRatio: 16.9,
                                    enlargeCenterPage: true,
                                    enableInfiniteScroll: true,
                                    scrollDirection: Axis.horizontal,
                                    height: MediaQuery.of(context).size.height *
                                        3 /
                                        8,
                                    initialPage: 0,
                                    autoPlay: true,
                                    onPageChanged: (index, reason) {
                                      setState(() {
                                        _current = index;
                                      });
                                    }),
                                items: postProvider.postMediaList
                                    .map((e) => Container(
                                            child: InkWell(
                                          onTap: () {},
                                          onLongPress: () {
                                            _removeAlertDialog(
                                                context,
                                                postProvider.postMediaList
                                                    .indexOf(e));
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
                                                              fit: BoxFit.cover,
                                                              height: 250)
                                                          : Image.file(
                                                              File(e.mediaPath),
                                                              fit: BoxFit.cover,
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
                                children: postProvider.postMediaList.map((url) {
                                  int index =
                                      postProvider.postMediaList.indexOf(url);
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
                            'No media added yet',
                          ),
                        ),
                  Container(
                    child: TextField(
                      onChanged: (String value) {
                        Provider.of<PostProvider>(context, listen: false)
                            .setPostTitle(postTitleController.text);
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
                        Provider.of<PostProvider>(context, listen: false)
                            .setPostDescription(postDescriptionController.text);
                      },
                      controller: postDescriptionController,
                      decoration: InputDecoration(
                        labelText: 'Write a caption',
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Semantics(
            label: 'image_picker_example_from_gallery',
            child: FloatingActionButton(
              backgroundColor: Theme.of(context).accentColor,
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
              backgroundColor: Theme.of(context).accentColor,
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
              backgroundColor: Theme.of(context).primaryColor,
              onPressed: () async {
                String desc = postDescriptionController.text.trim();
                String title = postTitleController.text.trim();

                if (desc.isNotEmpty && title.isNotEmpty) {
                  PostProvider provider =
                      Provider.of<PostProvider>(context, listen: false);

                  int i = await DatabaseHelper.instance.insertPost({
                    DatabaseHelper.columnTitle: provider.postTitle,
                    DatabaseHelper.columnDescription: provider.postDescription
                  });

                  CustomSnackBar(
                      context,
                      Text(
                        "The inserted id is $i",
                        style: TextStyle(
                          color:
                              Provider.of<ThemeProvider>(context, listen: false)
                                          .themeMode ==
                                      ThemeMode.dark
                                  ? Colors.black
                                  : Colors.white,
                        ),
                      ));
                  Provider.of<PostProvider>(context, listen: false).resetPost();
                  postTitleController.clear();
                  postDescriptionController.clear();
                } else {
                  CustomSnackBar(
                      context,
                      Text(
                        desc.isEmpty && title.isEmpty
                            ? "Fill in the details"
                            : desc.isEmpty
                                ? "Fill in description"
                                : "Fill in title",
                        style: TextStyle(
                          color:
                              Provider.of<ThemeProvider>(context, listen: false)
                                          .themeMode ==
                                      ThemeMode.dark
                                  ? Colors.black
                                  : Colors.white,
                        ),
                      ));
                }
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
