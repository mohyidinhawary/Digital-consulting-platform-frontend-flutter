import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import '../../../constants/constant.dart';

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({Key? key}) : super(key: key);

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  int currentIndex=0;
  GlobalKey<CurvedNavigationBarState> bottomNavigationKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
        key: bottomNavigationKey,
        index: 2,
        height: 60.0,
        items: <Widget>[
          Icon(Icons.account_balance_wallet_rounded, size: 30,color:Colors.white70),
          Icon(Icons.language, size: 30,color: Colors.white70,),
          Icon(Icons.home, size: 30,color:Colors.white70),
          Icon(Icons.date_range, size: 30,color: Colors.white70,),
          Icon(Icons.favorite, size: 30,color:Colors.pink),
        ],
        color:goldColor.withOpacity(0.6),
        buttonBackgroundColor: goldColor.withOpacity(0.6),
        backgroundColor: Colors.transparent,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 600),
        onTap: (index) {
          currentIndex=index;
          setState(() {

          });
        },
      );
  }
}
