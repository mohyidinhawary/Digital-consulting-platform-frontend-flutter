
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../constants/constant.dart';
import '../../screens/expert_profile_screen.dart';


class CAppointments extends StatefulWidget {
  const CAppointments({Key? key}) : super(key: key);

  @override
  State<CAppointments> createState() => _CAppointmentsState();
}

class _CAppointmentsState extends State<CAppointments> {
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
                      SizedBox(
                        width: 333,
                        child: Stack(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: goldColor,
                            ),
                          ],
                        ),
                      ),
                      // SizedBox(
                      //   width: MediaQuery.of(context).size.width / 3,
                      // ),

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
                        'client appointment title'.tr,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'headLine',
                          color: Colors.indigo.shade900,
                        ),
                      ),
                      Spacer(),
                      Text(
                        'view client appointment'.tr,
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
                              builder: (context) => ExpertProfileScreen(),
                            )),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15)),
                          width: MediaQuery.of(context).size.width / 1.4,
                          height: MediaQuery.of(context).size.height / 8,
                          child: Padding(
                            padding: const EdgeInsets.only(left:defaultPadding,bottom:defaultPadding,top:defaultPadding,right:5),
                            child: Container(
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
                                        BorderRadius.circular(15)),
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
                                            "Expert's name",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'headLine'),
                                          ),
                                          SizedBox(
                                            width: 18,
                                          ),
                                          Text(
                                            '1000\$',
                                            style: TextStyle(
                                                color: Colors.indigo.shade900,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        'Category: Medical',
                                        style: TextStyle(
                                            color: Colors.indigo.shade900,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
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
              SizedBox(height: defaultPadding),
              Padding(
                padding: const EdgeInsets.only(right: 8, left: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '1:30 pm',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'headLine',
                          color: Colors.grey.shade500),
                    ),
                    Slidable(
                      actionPane: SlidableDrawerActionPane(),
                      actionExtentRatio: 0.25,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)),
                        width: MediaQuery.of(context).size.width / 1.4,
                        height: MediaQuery.of(context).size.height / 8,
                        child: Padding(
                          padding: const EdgeInsets.only(left:defaultPadding,bottom:defaultPadding,top:defaultPadding,right:5),
                          child: Container(
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              "assets/images/doctor.jpg"),
                                          fit: BoxFit.cover),
                                      color: Colors.blueAccent,
                                      borderRadius: BorderRadius.circular(15)),
                                  height: 60,
                                  width: 60,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "expert's name",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'headLine'),
                                        ),
                                        SizedBox(
                                          width: 18,
                                        ),
                                        Text(
                                          '1000\$',
                                          style: TextStyle(
                                              color: Colors.indigo.shade900,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Category: career',
                                      style: TextStyle(
                                          color: Colors.indigo.shade900,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ],
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
