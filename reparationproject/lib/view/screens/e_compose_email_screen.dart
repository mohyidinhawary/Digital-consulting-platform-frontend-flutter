import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:reparationproject/view/screens/temporary_data.dart';
import '../widgets/crud/crud.dart';

class EComposeScreen extends StatefulWidget {
  EComposeScreen({Key? key}) : super(key: key);

  @override
  State<EComposeScreen> createState() => _EComposeScreenState();
}

class _EComposeScreenState extends State<EComposeScreen> {
  final List<String> menuTabItems = [
    'Schedule send',
    "Confidential Mode",
    "Discard",
    "Settings",
    "help and feedback"
  ];

  final fromController = TextEditingController();

  final toController = TextEditingController();

  final subjectController = TextEditingController();

  final composeController = TextEditingController();

  Crud crud = Crud();

  bool isLoading = false;

  postRequest(String url, Map data) async {
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      };
      var response = await http.post(Uri.parse(url), body: data);
      if (response.statusCode == 200) {
        print(data);
        print('success');
        print(response.body);
        var responseBody = jsonDecode(response.body);
        return responseBody;
      } else {
        print(data);
        print(response.body);
        print('Error ${response.statusCode}');
      }
    } catch (e) {
      print(data);
      print('ErrorCatch $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fromController.addListener(() => setState(() {}));
    toController.addListener(() => setState(() {}));
    subjectController.addListener(() => setState(() {}));
    composeController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    fromController.dispose();
    toController.dispose();
    subjectController.dispose();
    composeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          iconSize: 24,
          color: Colors.black54,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Compose',
          style: TextStyle(color: Colors.black54),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.attachment_outlined),
            iconSize: 24,
            color: Colors.black54,
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.send),
            iconSize: 24,
            color: Colors.black54,
            onPressed: () async {
              await postRequest(
                "http://10.0.2.2:8000/api/Send_expert_Massege/1/1",
                {
                  "subject": subjectController.text,
                  "user_name": toController.text,
                  "description": composeController.text

                },
              );
            },
          ),
          InkWell(
            child: PopupMenuButton(
              iconSize: 24,
              icon: Icon(
                Icons.more_vert_rounded,
                color: Colors.black54,
              ),
              itemBuilder: (context) => menuTabItems
                  .map(
                    (itemName) => PopupMenuItem(
                      child: Text(itemName),
                      value: itemName,
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
      body: InkWell(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Column(
          children: [
            TextField(
              controller: fromController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: kPadding),
                prefixIcon: Padding(
                  padding: EdgeInsets.only(
                      top: kPadding - 7,
                      left: kPadding - 10,
                      right: kPadding - 10),
                  child: Text(
                    'From',
                    style: TextStyle(color: Colors.black54, fontSize: 16),
                  ),
                ),
                hintText: 'example@mail.com',
                suffixIcon: IconButton(
                  icon: Icon(Icons.expand_more),
                  color: Colors.black54,
                  onPressed: () {},
                ),
              ),
            ),
            TextField(
              controller: toController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: kPadding - 4),
                prefixIcon: Padding(
                  padding: EdgeInsets.only(
                      top: kPadding - 7,
                      left: kPadding - 10,
                      right: kPadding - 10),
                  child: Text(
                    'To',
                    style: TextStyle(color: Colors.black54, fontSize: 16),
                  ),
                ),
                suffixIcon: IconButton(
                  icon: Icon(Icons.expand_more),
                  color: Colors.black54,
                  onPressed: () {},
                ),
              ),
            ),
            TextField(
              controller: subjectController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(
                    top: kPadding - 10,
                    left: kPadding - 10,
                    right: kPadding - 10),
                hintText: 'Subject',
              ),
            ),
            TextField(
              controller: composeController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(
                    top: kPadding - 10,
                    left: kPadding - 10,
                    right: kPadding - 10),
                hintText: 'Compose',
                enabledBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                border: InputBorder.none,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
