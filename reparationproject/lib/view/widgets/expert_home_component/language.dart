
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/constant.dart';
import '../../../locale/locale_controller.dart';
import '../language_components/button.dart';
import '../language_components/buttontapped.dart';

class ELanguage extends StatefulWidget {
  const ELanguage({Key? key}) : super(key: key);

  @override
  State<ELanguage> createState() => _ELanguageState();
}

class _ELanguageState extends State<ELanguage> {


  //

  bool buttonPressed1 = false;
  bool buttonPressed2 = false;
  bool buttonPressed3 = false;
  bool buttonPressed4 = false;




  @override
  Widget build(BuildContext context) {
    MyLocaleController controllerLang=Get.find();
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body:SafeArea(
        child: Center(
          child:
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('language title'.tr,style:TextStyle(
                    fontSize:25,fontWeight: FontWeight.bold,fontFamily:'headLine',
                  ),),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: InkWell(
                            onTap: (){
                              controllerLang.changeLang('ar');
                            },
                            child: GestureDetector(
                              // FIRST BUTTON
                                onTap: (){
                                  setState(() {
                                    buttonPressed1 = true;
                                    buttonPressed2 = false;
                                  });
                                  controllerLang.changeLang('ar');
                                },
                                child: buttonPressed1
                                    ? ButtonTapped(
                                  text: '1st lang'.tr,
                                )
                                    : MyButton(
                                  text: '1st lang'.tr,
                                )),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            // SECOND BUTTON
                              onTap: (){
                                setState(() {
                                  buttonPressed1 = false;
                                  buttonPressed2 = true;
                                });
                                controllerLang.changeLang('en');
                                },
                              child: buttonPressed2
                                  ? ButtonTapped(
                                text: '2nd lang'.tr,
                              )
                                  : MyButton(
                               text: '2nd lang'.tr,
                              )),
                        ),

                      ],
                    ),
                  )
                ],
              ),
          ),
      ),
      );
  }
}
