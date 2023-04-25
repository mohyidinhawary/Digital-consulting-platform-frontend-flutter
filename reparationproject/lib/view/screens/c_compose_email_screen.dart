import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:reparationproject/view/screens/temporary_data.dart';
import '../widgets/client_home_components/mail.dart';
import '../widgets/crud/crud.dart';

class CComposeScreen extends StatefulWidget {
  CComposeScreen({Key? key}) : super(key: key);

  @override
  State<CComposeScreen> createState() => _CComposeScreenState();
}

class _CComposeScreenState extends State<CComposeScreen> {
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

  bool isLoading = false;

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
              var response = await postRequest(
                'http://10.0.2.2:8000/api/Send_user_Massege/1/1',
                {
                  "subject": subjectController.text,
                  "expert_name": toController.text,
                  "description": composeController.text
                },
              );
              if (response['status'] == 1) {
                AwesomeDialog(
                  dialogType: DialogType.success,
                  context: context,
                  title: 'warning',
                  body: Text(
                    'Message sent successfully',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                  animType: AnimType.scale,
                  padding: EdgeInsets.all(8),
                  barrierColor: Colors.grey.shade300,
                  alignment: Alignment.center,
                  autoHide: const Duration(seconds: 10),
                )..show();
              }
              if (response['status'] == 0) {
                AwesomeDialog(
                  dialogType: DialogType.error,
                  context: context,
                  title: 'warning',
                  body: Text(
                    " User not found please make sure that the name is correct",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                  animType: AnimType.scale,
                  padding: EdgeInsets.all(8),
                  // btnCancel:Text('cancel',textAlign: TextAlign.center,style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                  barrierColor: Colors.grey.shade300,
                  alignment: Alignment.center,
                  autoHide: const Duration(seconds: 10),
                )..show();
              }
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
