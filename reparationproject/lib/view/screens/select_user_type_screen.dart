import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:get/get.dart';
import '../../constants/constant.dart';
import '../../main.dart';
import 'client_sign_in_screen.dart';
import 'client_sign_up_screen.dart';
import 'expert_sign_in_screen.dart';
import 'expert_sign_up_screen.dart';

class SelectUserTypeScreen extends StatefulWidget {
  SelectUserTypeScreen({Key? key}) : super(key: key);

  @override
  State<SelectUserTypeScreen> createState() => _SelectUserTypeScreenState();
}

List<Image> Gendre = [
  Image.asset('assets/images/client.jpg'),
  Image.asset('assets/images/expert.jpg'),
].toList();

class _SelectUserTypeScreenState extends State<SelectUserTypeScreen> {
  var selected = 0;
  var _listTextTabToggle = ["1st type".tr, "2nd type".tr];
  int index = 0;
  CarouselController carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image(
            image: AssetImage(
              'assets/images/Sign_Up_bg.png',
            ),
            height: MediaQuery.of(context).size.height * 1.3,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.fill,
          ),
          SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: defaultPadding),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'select user type title'.tr,
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'headLine'),
                    ),
                    Spacer(),
                    Stack(
                      children: [
                        // AnimatedContainer(
                        //   margin: EdgeInsets.only(
                        //     bottom: MediaQuery.of(context).size.height * 0.18,
                        //     top: MediaQuery.of(context).size.height * 0.18,
                        //     left: selected == 0
                        //         ? MediaQuery.of(context).size.height * 0.14
                        //         : MediaQuery.of(context).size.height * 0.1,
                        //     right: selected == 0
                        //         ? MediaQuery.of(context).size.height * 0.08
                        //         : MediaQuery.of(context).size.height * 0.1,
                        //   ),
                        //   width: MediaQuery.of(context).size.width * 0.5,
                        //   height: MediaQuery.of(context).size.width * 0.5,
                        //   decoration: BoxDecoration(
                        //       shape: BoxShape.circle,
                        //       color: selected == 0
                        //           ? Color.fromARGB(255, 185, 224, 255)
                        //           : Color.fromARGB(255, 255, 214, 236)),
                        //   duration: Duration(microseconds: 3),
                        // ),
                        CarouselSlider(
                          carouselController: carouselController,
                          items: [
                            Image(
                              width: MediaQuery.of(context).size.width,
                              image:
                                  const AssetImage('assets/images/client.png'),
                              height: MediaQuery.of(context).size.height * 0.6,
                              fit: BoxFit.cover,
                            ),
                            Image(
                              image: AssetImage('assets/images/expert.png'),
                              fit: BoxFit.cover,
                            ),
                          ],
                          options: CarouselOptions(
                            enlargeStrategy: CenterPageEnlargeStrategy.scale,
                            height: 390,
                            viewportFraction: 0.6,
                            initialPage: 0,
                            enableInfiniteScroll: false,
                            enlargeCenterPage: true,
                            scrollDirection: Axis.horizontal,
                            onPageChanged: (index, reason) {
                              setState(() {
                                selected = index;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    FlutterToggleTab(
                      // width in percent
                      width: MediaQuery.of(context).size.width / 6,
                      borderRadius: 30,
                      height: 50,
                      selectedIndex: selected,
                      selectedBackgroundColors: [mintColor, mintColor],
                      selectedTextStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w700),
                      unSelectedTextStyle: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                      labels: _listTextTabToggle,
                      selectedLabelIndex: (index) {
                        setState(() {
                          carouselController.animateToPage(index);
                          selected = index;
                        });
                      },
                      isScroll: false,
                    ),
                    // SizedBox(
                    //   height: MediaQuery.of(context).size.height / 13.8,
                    // ),
                    SizedBox(
                      height: 18,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: defaultPadding),
                      child: SizedBox(
                        width: double.infinity,
                        child: MaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          splashColor: mintColor,
                          minWidth: MediaQuery.of(context).size.width / 1.2,
                          height: MediaQuery.of(context).size.height / 18,
                          color: mintColor,
                          child: Text(
                            'SU button'.tr,
                            style: TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          onPressed: () {
                            sharedPref.setString(
                                'selected', selected.toString());
                            print(
                              sharedPref.getString('selected'),
                            );
                            if (selected == 0) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ClientSignUpScreen(),
                                ),
                              );
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ExpertSignUpScreen(),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: defaultPadding),
                      child: SizedBox(
                        width: double.infinity,
                        child: MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: BorderSide(width: 4, color: mintColor)),
                          splashColor: mintColor,
                          minWidth: MediaQuery.of(context).size.width / 1.2,
                          height: MediaQuery.of(context).size.height / 18,
                          color: Colors.white,
                          child: Text(
                            'SI button'.tr,
                            style: TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.bold,
                                color: mintColor),
                          ),
                          onPressed: () {
                            sharedPref.setString(
                                'selected', selected.toString());
                            print(
                              sharedPref.getString('selected'),
                            );
                            if (selected == 0) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ClientSignInScreen(),
                                ),
                              );
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ExpertSignInScreen(),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
