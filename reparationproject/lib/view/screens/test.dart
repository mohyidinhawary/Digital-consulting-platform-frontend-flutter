import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../constants/constant.dart';


class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  String? _path;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body:  SafeArea(
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          CircleAvatar(
            radius: 60,
            backgroundColor: goldColor,
            foregroundImage: _path == null
                ? null
                : FileImage(File(_path!)),
            child: Icon(
              Icons.person,
              size: 60,
              color: blueColor,
            ),
          ),
          Positioned(
            top: 87,
            left: 77,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 25,
              child: CircleAvatar(
                backgroundColor:
                blueColor,
                child: IconButton(
                  onPressed: () async {
                    var imagePicker =
                    ImagePicker();
                    var xfile = _path == null
                        ? await imagePicker
                        .pickImage(
                        source:
                        ImageSource
                            .gallery)
                        : _path = null;
                    if (xfile != null) {
                      setState(() {
                        _path = xfile.path;
                      });
                    } else {
                      setState(() {
                        _path = null;
                      });
                    }
                  },
                  icon: _path == null
                      ? Icon(Icons.add)
                      : Icon(Icons.delete),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
    );
  }
}
