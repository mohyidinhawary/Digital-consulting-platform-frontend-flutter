import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shimmer/shimmer.dart';

import '../../../constants/constant.dart';
import '../../screens/business_category.dart';
import '../../screens/career_category_screen.dart';
import '../../screens/expert_profile_screen.dart';
import '../../screens/family_categoty.dart';
import '../../screens/grid_view_doctor_screen.dart';
import '../../screens/medical_category.dart';
import '../../screens/psycho_category.dart';
import '../crud/crud.dart';
import 'custom_category_container.dart';
import 'custom_experts_contatiner.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late final String? img;

  final searchController = TextEditingController();

  Crud crud = Crud();

  bool isLoading = false;

  search() async {
    var response = await crud.postRequest(
      'http://192.168.137.117:8000/api/search',
      {"name": searchController.text},
    );

    if (response != null) {
    } else {
      AwesomeDialog(
        dialogType: DialogType.infoReverse,
        context: context,
        title: 'warning',
        body: Text(
          "cannot find this name",
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

  fetchExperts() async {
    var response = await http.get(
      Uri.parse('http://10.0.2.2:8000/api/get'),
    );
    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      print("success");
      return responseBody;
    }
  }

  @override
  void initState() {
    super.initState();
    searchController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    height: 180,
                    decoration: BoxDecoration(
                        color: goldColor.withOpacity(0.6),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30))),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(
                          defaultPadding, 0, defaultPadding, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'welcome home'.tr,
                            style: TextStyle(
                                fontFamily: 'headLine',
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          Text(
                            'help home'.tr,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'headLine'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.fromLTRB(8, defaultPadding * 3, 8, 0),
                    child: TextFormField(
                      controller: searchController,
                      decoration: InputDecoration(
                        prefixIcon: InkWell(
                          onTap: () async {
                            var response = await postRequest(
                              'http://10.0.2.2:8000/api/search',
                              {
                                "name": searchController.text,
                              },
                            );
                            if (response['status'] == 1) {
                              print('success');
                              print(response.body);
                            } else {
                              AwesomeDialog(
                                dialogType: DialogType.infoReverse,
                                context: context,
                                title: 'warning',
                                body: Text(
                                  "cannot find this name",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
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
                          child: Icon(Icons.search,
                              color: goldColor.withOpacity(0.9),
                              size: 33,
                              shadows: [Shadow(color: Colors.black)]),
                        ),
                        hintText: "search home".tr,
                        hintStyle: TextStyle(
                            fontSize: 18,
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w300),
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.white70,
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: goldColor.withOpacity(0.5)),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide:
                                BorderSide(color: goldColor.withOpacity(0.5))),
                      ),
                      validator: usernameValidator,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'categories home'.tr,
                        style: TextStyle(
                            fontFamily: 'headLine',
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 115,
                margin: EdgeInsets.only(left: 15),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            MedicalCategoryScreen(),
                                      ),
                                    );
                                  },
                                  child: CustomCategoryContainer(goldColor)),
                              Positioned(
                                top: 15,
                                left: 18,
                                child: FaIcon(
                                  FontAwesomeIcons.userDoctor,
                                  color: Colors.white70,
                                  size: 50,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            '1st category'.tr,
                            style: TextStyle(
                              color: Colors.grey.shade700,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            PsychoCategoryScreen(),
                                      ),
                                    );
                                  },
                                  child: CustomCategoryContainer(mintColor)),
                              Positioned(
                                top: 15,
                                left: 15,
                                child: FaIcon(
                                  FontAwesomeIcons.brain,
                                  color: Colors.white70,
                                  size: 50,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            '2nd category'.tr,
                            style: TextStyle(
                              color: Colors.grey.shade700,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            BusinessCategoryScreen(),
                                      ),
                                    );
                                  },
                                  child: CustomCategoryContainer(blueColor)),
                              Positioned(
                                top: 15,
                                left: 13,
                                child: FaIcon(
                                  FontAwesomeIcons.businessTime,
                                  color: Colors.white70,
                                  size: 50,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            '3rd category'.tr,
                            style: TextStyle(
                              color: Colors.grey.shade700,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            FamilyCategoryScreen(),
                                      ),
                                    );
                                  },
                                  child: CustomCategoryContainer(
                                      Colors.grey.shade600)),
                              Positioned(
                                top: 15,
                                left: 13,
                                child: FaIcon(
                                  FontAwesomeIcons.peoplePulling,
                                  color: Colors.white70,
                                  size: 50,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            '4th category'.tr,
                            style: TextStyle(
                              color: Colors.grey.shade700,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            CareerCategoryScreen(),
                                      ),
                                    );
                                  },
                                  child: CustomCategoryContainer(goldColor)),
                              Positioned(
                                top: 15,
                                left: 11,
                                child: FaIcon(
                                  FontAwesomeIcons.peopleCarryBox,
                                  color: Colors.white70,
                                  size: 50,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            '5th category'.tr,
                            style: TextStyle(
                              color: Colors.grey.shade700,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'experts home'.tr,
                        style: TextStyle(
                            fontFamily: 'headLine',
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => GridViewDoctorScreen(),
                          ),
                        );
                      },
                      child: Text(
                        'view home'.tr,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: goldColor),
                      ),
                    ),
                  ],
                ),
              ),
              FutureBuilder<dynamic>(
                future: fetchExperts(),
                builder: (context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                      height: 185,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => Shimmer.fromColors(
                          highlightColor: Colors.grey.shade100,
                          enabled: true,
                          loop: 4,
                          baseColor: Colors.red,
                          period: Duration(seconds: 5),
                          child: Container(
                            margin: EdgeInsets.fromLTRB(15, 5, 5, 0),
                            height: 300,
                            width: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                  return Container(
                    height: 185,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data.length,
                      // itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        print(
                          snapshot.data[index]['experiences'],
                        );
                        print(
                          snapshot.data[index]['name'],
                        );
                        return Stack(
                          alignment: Alignment.center,
                          children: [
                            InkWell(
                              child: CustomExpertContainer(),
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ExpertProfileScreen(),
                                ));
                              },
                            ),
                            Positioned(
                              right: 13,
                              top: 13,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 115,
                                    width: 185,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              "assets/images/doctor.jpg"),
                                          fit: BoxFit.cover),
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 2, 0, 0),
                                    child: Text(
                                      snapshot.data[index]['name'],
                                      style: TextStyle(
                                          fontFamily: 'headLine',
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          textBaseline:
                                              TextBaseline.alphabetic),
                                    ),
                                  ),
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        snapshot.data[index]['experiences'],
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
