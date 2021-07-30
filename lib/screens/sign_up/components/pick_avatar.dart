import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop_app/consts/colors.dart';

class PickAvatar extends StatefulWidget {
  const PickAvatar({Key? key}) : super(key: key);

  @override
  _PickAvatarState createState() => _PickAvatarState();
}

class _PickAvatarState extends State<PickAvatar> {
  File? _pickedImage;
  void _pickImageCamera() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.camera);
    final pickedImageFile = File(pickedImage!.path);
    setState(() {
      _pickedImage = pickedImageFile;
    });
    Navigator.pop(context);
  }

  void _pickImageGallery() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.gallery);
    final pickedImageFile = File(pickedImage!.path);
    setState(() {
      _pickedImage = pickedImageFile;
    });
    Navigator.pop(context);
  }

  void _remove() {
    setState(() {
      _pickedImage = null;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
          child: CircleAvatar(
            radius: 71,
            backgroundColor: ColorsConsts.gradiendLEnd,
            child: CircleAvatar(
              radius: 65,
              backgroundColor: ColorsConsts.gradiendFEnd,
              backgroundImage:
                  _pickedImage == null ? null : FileImage(_pickedImage!),
            ),
          ),
        ),
        Positioned(
            top: 120,
            left: 110,
            child: RawMaterialButton(
              elevation: 10,
              fillColor: ColorsConsts.gradiendLEnd,
              child: Icon(Icons.add_a_photo),
              padding: EdgeInsets.all(15.0),
              shape: CircleBorder(),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(
                          'Choose option',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: ColorsConsts.gradiendLStart),
                        ),
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: [
                              InkWell(
                                onTap: _pickImageCamera,
                                splashColor: Colors.purpleAccent,
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.camera,
                                        color: Colors.purpleAccent,
                                      ),
                                    ),
                                    Text(
                                      'Camera',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          color: ColorsConsts.title),
                                    )
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: _pickImageGallery,
                                splashColor: Colors.purpleAccent,
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.image,
                                        color: Colors.purpleAccent,
                                      ),
                                    ),
                                    Text(
                                      'Gallery',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          color: ColorsConsts.title),
                                    )
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: _remove,
                                splashColor: Colors.purpleAccent,
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.remove_circle,
                                        color: Colors.red,
                                      ),
                                    ),
                                    Text(
                                      'Remove',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.red),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              },
            ))
      ],
    );
  }
}
