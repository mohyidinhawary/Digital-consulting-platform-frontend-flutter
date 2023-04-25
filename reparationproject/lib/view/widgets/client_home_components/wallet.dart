import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../constants/constant.dart';

class CMyWallet extends StatefulWidget {
  const CMyWallet({Key? key}) : super(key: key);

  @override
  State<CMyWallet> createState() => _CMyWalletState();
}

class _CMyWalletState extends State<CMyWallet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: Column(
                children: [
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
          ),
        ));
  }
}
