import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/constant.dart';

class ClientProfileScreen extends StatefulWidget {
  const ClientProfileScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ClientProfileScreen> createState() => _ClientProfileScreenState();
}

class _ClientProfileScreenState extends State<ClientProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
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
                                  child: Icon(
                                    Icons.call,
                                    size: 40,
                                    color: Color(0xff4CA7C1),
                                  )),
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
                        height: 200,
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 65,
                              backgroundColor: Color(0xff4CA7C1),
                              child: CircleAvatar(
                                backgroundColor: Color(0xffFFFFFF),
                                backgroundImage:
                                    AssetImage('assets/images/doctor.jpg'),
                                radius: 60,
                              ),
                            ),
                            Container(
                                padding: EdgeInsets.only(top: 10),
                                child: Text(
                                  "Mohammad Jabber",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 17),
                                )),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 4, 0, 0),
                              child: Text(
                                "Booking id: 1102",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black38),
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
                                  child: Icon(
                                    Icons.chat,
                                    size: 40,
                                    color: Color(0xff4CA7C1),
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
                            "amount".tr,
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 16),
                          ),
                          Container(
                              padding: EdgeInsets.only(top: 5),
                              child: Text("\$10000")),
                        ],
                      )),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "date".tr,
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 16),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                              child: Text("12-10-2022"),
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
                                'time'.tr,
                                style: TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 16),
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(33, 5, 33, 0),
                                child: Row(children: [
                                  Text("4:30 pm"),
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
                padding: EdgeInsets.only(top: defaultPadding),
                child: Divider(
                  thickness: 1,
                  indent: 85,
                  endIndent: 85,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18,right: 18),
                child: Container(
                  margin: EdgeInsets.fromLTRB(0, defaultPadding*1.8, 0, 0),

                  height: 25,
                  width: 380,
                  child: Row(
                    children: [
                      Text(
                        'client name'.tr,
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Lura codec",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18,right: 18),
                child: Container(
                  margin: EdgeInsets.fromLTRB(0, defaultPadding*1.8, 0, 0),

                  height: 23,
                  width: 380,
                  child: Row(
                    children: [
                      Text(
                        "phone".tr,
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "0934027991",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18,right: 18),
                child: Container(
                  margin: EdgeInsets.fromLTRB(0, defaultPadding*1.8, 0, 0),

                  height: 25,
                  width: 380,
                  child: Row(
                    children: [
                      Text(
                        'address'.tr,
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Baghdad Street",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18,right: 18),
                child: Container(
                  margin: EdgeInsets.fromLTRB(0, defaultPadding*1.8, 0, 0),

                  height: 25,
                  width: 380,
                  child: Row(
                    children: [
                      Text(
                        'CP consultation type'.tr,
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "medical",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18,right: 18),
                child: Container(
                  margin: EdgeInsets.fromLTRB(0, defaultPadding*1.8, 0, 0),

                  height: 25,
                  width: 380,
                  child: Row(
                    children: [
                      Text(
                        'CP appointment period'.tr,
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
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

            ],
          ),
        ),
      ),
    );
  }
}
