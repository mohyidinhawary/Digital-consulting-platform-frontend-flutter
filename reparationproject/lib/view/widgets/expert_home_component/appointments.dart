import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../constants/constant.dart';
import '../../../main.dart';
import '../../screens/client_profile_screen.dart';
import '../../screens/expert_sign_in_screen.dart';
import 'language.dart';
import 'package:http/http.dart' as http;

class EAppointments extends StatefulWidget {
  const EAppointments({Key? key}) : super(key: key);

  @override
  State<EAppointments> createState() => _EAppointmentsState();
}

class _EAppointmentsState extends State<EAppointments> {
 static Future fetchExperts() async {
    var response = await http.get(
      Uri.parse('http://10.0.2.2:8000/api/show/1'),
    );
    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      print('success');
      print(response.body);
      return responseBody;
    } else {
      print('failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(
                    defaultPadding, defaultPadding, defaultPadding, 0),
                child: SizedBox(
                  height: 30,
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ELanguage(),
                            ),
                          );
                        },
                        child: Icon(
                          Icons.language,
                          color: Colors.indigo.shade900,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.27,
                      ),
                      InkWell(
                        onTap: () {
                          sharedPref.clear();
                          print(
                            sharedPref.getString('token'),
                          );
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                            builder: (context) {
                              return ExpertSignInScreen();
                            },
                          ), (route) => false);
                        },
                        child: Icon(
                          Icons.logout_sharp,
                          color: Colors.indigo.shade900,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: defaultPadding,
              ),
              Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search,
                        color: Colors.indigo.shade900,
                        size: 33,
                        shadows: [Shadow(color: Colors.black)]),
                    hintText: "search C appointments".tr,
                    hintStyle: TextStyle(
                        fontSize: 18,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w300),
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white70,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: goldColor.withOpacity(0.5)),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: Colors.grey.shade200,
                      ),
                    ),
                  ),
                  validator: usernameValidator,
                ),
              ),
              SizedBox(
                height: defaultPadding,
              ),
              Container(
                width: double.infinity,
                height: 50,
                color: goldColor.withOpacity(0.4),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: defaultPadding),
                  child: Row(
                    children: [
                      Text(
                        'expert appointment title'.tr,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'headLine',
                          color: Colors.indigo.shade900,
                        ),
                      ),
                      Spacer(),
                      Text(
                        'view home'.tr,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'headLine',
                          color: Colors.indigo.shade300,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: defaultPadding,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8, left: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '12:30 pm',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'headLine',
                          color: Colors.grey.shade500),
                    ),
                    Slidable(
                      actionPane: SlidableDrawerActionPane(),
                      actionExtentRatio: 0.25,
                      child: InkWell(
                        onTap: () =>
                            Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ClientProfileScreen(),
                        )),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15)),
                          width: MediaQuery.of(context).size.width / 1.4,
                          height: MediaQuery.of(context).size.height / 8,
                          child: Padding(
                            padding: const EdgeInsets.all(defaultPadding),
                            child: FutureBuilder(
                              future: fetchExperts(),
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                return ListView.builder(
                                    itemCount: snapshot
                                        .data['your reservations is'].length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      print(
                                        snapshot.data['your reservations is']
                                            [index]["id"],
                                      );
                                      print(
                                        snapshot.data['your reservations is']
                                            [index]['day'],
                                      );
                                      print(
                                        snapshot.data["your reservations is"]
                                            [index]["date"],
                                      );
                                      return Container(
                                        child: Row(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: AssetImage(
                                                          "assets/images/doctor.jpg"),
                                                      fit: BoxFit.cover),
                                                  color: Colors.blueAccent,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                              height: 60,
                                              width: 60,
                                            ),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      snapshot.data[
                                                              'your reservations is']
                                                          [index]["id"].toString(),
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily:
                                                              'headLine'),
                                                    ),
                                                    SizedBox(
                                                      width: 75,
                                                    ),
                                                    Text(
                                                      snapshot.data[
                                                              "your reservations is"]
                                                          [index]['day'].toString(),
                                                      style: TextStyle(
                                                          color: Colors
                                                              .indigo.shade900,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  snapshot.data[
                                                          "your reservations is"]
                                                      [index]["date"].toString(),
                                                  style: TextStyle(
                                                      color: Colors
                                                          .indigo.shade900,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    });
                              },
                            ),
                          ),
                        ),
                      ),
                      actions: <Widget>[
                        IconSlideAction(
                          caption: 'Call',
                          color: mintColor,
                          icon: Icons.phone,
                          onTap: () {},
                        ),
                      ],
                      secondaryActions: <Widget>[
                        IconSlideAction(
                          caption: 'Message',
                          color: goldColor,
                          icon: Icons.message_rounded,
                          onTap: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
