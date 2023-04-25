import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';

import '../../constants/constant.dart';
import 'expert_profile_screen.dart';
import 'package:http/http.dart' as http;

class MedicalCategoryScreen extends StatefulWidget {
  const MedicalCategoryScreen({Key? key}) : super(key: key);

  @override
  State<MedicalCategoryScreen> createState() => _MedicalCategoryScreenState();
}

class _MedicalCategoryScreenState extends State<MedicalCategoryScreen> {
  final List<Map<String, dynamic>> gridMap = [
    {"images": 'assets/images/doctor.jpg'},
    {"images": 'assets/images/doctor.jpg'},
    {"images": 'assets/images/doctor.jpg'},
    {"images": 'assets/images/doctor.jpg'},
    {"images": 'assets/images/doctor.jpg'},
    {"images": 'assets/images/doctor.jpg'},
    {"images": "assets/images/doctor.jpg"},
    {"images": "assets/images/doctor.jpg"},
    {"images": "assets/images/doctor.jpg"},
    {"images": "assets/images/doctor.jpg"},
    {"images": "assets/images/doctor.jpg"},
    {"images": "assets/images/doctor.jpg"},
    {"images": "assets/images/doctor.jpg"},
    {"images": "assets/images/doctor.jpg"},
    {"images": "assets/images/doctor.jpg"},
    {"images": "assets/images/doctor.jpg"},
    {"images": "assets/images/doctor.jpg"}
  ];

  fetchExperts() async {
    var response = await http.get(
      Uri.parse('http://10.0.2.2:8000/api/browse_Consulting'),
    );
    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      print('success');
      return responseBody;
      // var request = http.Request(
      //     'GET', Uri.parse('http://10.0.2.2:8000/api/get'));
      // http.StreamedResponse response = await request.send();
      // if (response.statusCode == 200) {
      //   print(await response.stream.bytesToString());
      //   print('success');
      //   print();
      // } else {
      //   print(response.reasonPhrase);
      // }

    } else {
      print('failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
              left: defaultPadding, right: defaultPadding, top: defaultPadding),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search,
                        color: goldColor.withOpacity(0.9),
                        size: 33,
                        shadows: [Shadow(color: Colors.black)]),
                    hintText: 'help home'.tr,
                    hintStyle: TextStyle(
                        fontSize: 18,
                        color: Colors.grey.shade700,
                        fontWeight: FontWeight.w300),
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.grey.shade300,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: goldColor.withOpacity(0.5)),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: goldColor.withOpacity(0.5),
                      ),
                    ),
                  ),
                  validator: usernameValidator,
                ),
                SizedBox(
                  height: 20,
                ),
                FutureBuilder(
                    future: fetchExperts(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if(snapshot.hasData) {
                        return GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12.0,
                            mainAxisSpacing: 12.0,
                            mainAxisExtent: 270,
                          ),
                          itemCount: snapshot
                              .data["Consulting"]["Medical_consultations"]
                              .length,
                          itemBuilder: (BuildContext context, int index) {
                            print(snapshot.data["Consulting"]
                                ["Medical_consultations"][index]["name"]);
                            return InkWell(
                              onTap: () async {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => ExpertProfileScreen(),
                                  ),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    16.0,
                                  ),
                                  color: goldColor.withOpacity(0.6),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(16.0),
                                        topRight: Radius.circular(16.0),
                                      ),
                                      child: Image.asset(
                                        "${gridMap.elementAt(index)['images']}",
                                        height: 170,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            snapshot.data["Consulting"]
                                                    ["Medical_consultations"]
                                                [index]["name"],
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle1!
                                                .merge(
                                                  const TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                          ),
                                          Row(
                                            children: [
                                              LikeButton(),
                                              IconButton(
                                                onPressed: () {},
                                                icon: Icon(
                                                  Icons.date_range,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }
                      return CircularProgressIndicator();
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
