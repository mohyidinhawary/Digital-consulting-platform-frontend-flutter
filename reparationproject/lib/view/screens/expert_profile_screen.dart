import 'dart:convert';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reparationproject/view/screens/video_call_screen.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';
import 'package:http/http.dart' as http;
import '../widgets/crud/crud.dart';
import 'audio_call_screen.dart';
import 'book_appointment_screen.dart';

class ExpertProfileScreen extends StatefulWidget {
  const ExpertProfileScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ExpertProfileScreen> createState() => _ExpertProfileScreenState();
}

class _ExpertProfileScreenState extends State<ExpertProfileScreen> {
  double ratingValue = 0;
  Crud crud = Crud();

  fetchExperts() async {
    var response = await http.get(
      Uri.parse('http://10.0.2.2:8000/api/expert_profile/11'),
    );
    if (response.statusCode == 200) {
      print('success');
      print(response.statusCode);
      var responseBody = jsonDecode(response.body);
      print(response.body);
      return responseBody;
    }
  }

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
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: fetchExperts(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return Container(
                height: 800,
                width: 800,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(0, 85, 0, 0),
                            child: Container(
                              height: 200,
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Color(0xff4CA7C1),
                                    radius: 30,
                                    child: CircleAvatar(
                                      backgroundColor: Color(0xffFFFFFF),
                                      radius: 25,
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  AudioCallScreen(),
                                            ),
                                          );
                                        },
                                        child: Icon(
                                          Icons.call,
                                          size: 40,
                                          color: Color(0xff4CA7C1),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                            child: Container(
                              height: 250,
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    radius: 65,
                                    backgroundColor: Color(0xff4CA7C1),
                                    child: CircleAvatar(
                                      backgroundColor: Color(0xffFFFFFF),
                                      backgroundImage: AssetImage(
                                          'assets/images/doctor.jpg'),
                                      radius: 60,
                                    ),
                                  ),
                                  Container(
                                      padding: EdgeInsets.only(top: 10),
                                      child: Text(
                                        snapshot.data[0]['name'],
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 17),
                                      )),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 4, 0, 0),
                                    child: Text(
                                      snapshot.data[0]['experiences'],
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black38),
                                    ),
                                  ),
                                  SizedBox(height: 18),
                                  Center(
                                    child: SmoothStarRating(
                                      rating: ratingValue,
                                      size: 24,
                                      filledIconData: Icons.star,
                                      halfFilledIconData: Icons.star_half,
                                      defaultIconData: Icons.star_border,
                                      color: Colors.amber,
                                      borderColor: Colors.amber,
                                      starCount: 5,
                                      allowHalfRating: true,
                                      spacing: 2.0,
                                      onRatingChanged: (value) async {
                                        setState(() {
                                          ratingValue = value;
                                        });
                                        postRequest(
                                            "http://10.0.2.2:8000/api/rate/2/3",
                                            {
                                              "rate": ratingValue.toString(),
                                            });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(0, 85, 0, 0),
                            child: Container(
                              height: 200,
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Color(0xff4CA7C1),
                                    radius: 30,
                                    child: CircleAvatar(
                                        backgroundColor: Color(0xffFFFFFF),
                                        radius: 25,
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    VideoCallScreen(),
                                              ),
                                            );
                                          },
                                          child: Icon(
                                            Icons.video_call,
                                            size: 40,
                                            color: Color(0xff4CA7C1),
                                          ),
                                        )),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: Row(
                          children: [
                            Expanded(
                                child: Column(
                              children: [
                                Text(
                                  "expert fees".tr,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16),
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        snapshot.data[0]["session_price"]
                                            .toString(),
                                      ),
                                      Text(
                                        '\$',
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            )),
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    "expert experience".tr,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16),
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                    child: Text(
                                      snapshot.data[0]["experiences"],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                child: Column(
                                  children: [
                                    Text(
                                      'experts rates'.tr,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16),
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.fromLTRB(40, 5, 35, 0),
                                      child: Row(children: [
                                        Icon(
                                          Icons.favorite_rounded,
                                          color: Colors.deepOrange,
                                        ),
                                        Text("4.91"),
                                      ]),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 24),
                      child: Divider(
                        thickness: 1,
                        indent: 85,
                        endIndent: 85,
                      ),
                    ),
                    SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: Container(
                        margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                        height: 25,
                        width: 380,
                        child: Row(
                          children: [
                            Text("phone".tr,
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w500)),
                            Text(snapshot.data[0]["phone_number"],
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w500))
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: Container(
                        margin: EdgeInsets.fromLTRB(0, 35, 0, 0),
                        padding: EdgeInsets.fromLTRB(0, 3, 0, 0),
                        height: 25,
                        width: 380,
                        child: Row(
                          children: [
                            Text(
                              "center address".tr,
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w500),
                            ),
                            Text(
                              snapshot.data[0]["address"],
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: Container(
                        margin: EdgeInsets.fromLTRB(0, 35, 0, 0),
                        padding: EdgeInsets.fromLTRB(0, 3, 0, 0),
                        height: 25,
                        width: 380,
                        child: Row(
                          children: [
                            Text(
                              "consultation type".tr,
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w500),
                            ),
                            Text(
                              snapshot.data[0]["experiences"],
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: Container(
                        margin: EdgeInsets.fromLTRB(0, 40, 0, 0),
                        padding: EdgeInsets.fromLTRB(0, 3, 0, 0),
                        height: 25,
                        width: 380,
                        child: Row(
                          children: [
                            Text(
                              "appointment period".tr,
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w500),
                            ),
                            Text(
                              "30 minutes",
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BookAppointmentScreen(),
                            ),
                          );
                        },
                        child: Container(
                          height: 50,
                          width: 160,
                          margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                          decoration: BoxDecoration(
                            color: Color(0xff4CA7C1),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                            child: Text(
                              "book appointment".tr,
                              style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
