import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../constants/constant.dart';
import '../../../main.dart';
import '../../screens/expert_sign_in_screen.dart';
import 'language.dart';

class EMyWallet extends StatefulWidget {
  const EMyWallet({Key? key}) : super(key: key);

  @override
  State<EMyWallet> createState() => _EMyWalletState();
}

class _EMyWalletState extends State<EMyWallet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        body: SafeArea(
          child: Center(
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
                            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
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

                SizedBox(height:40),
                Text(
                  'wallet title'.tr,
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'headLine',
                      color: Colors.black),
                ),
                SizedBox(height: 30,),
                Lottie.asset('assets/gifs/116065-wallet-animation.json',
                    fit: BoxFit.fill, height: 400),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'wallet subtitle'.tr,
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                    Text(
                      ' 500\$',
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
