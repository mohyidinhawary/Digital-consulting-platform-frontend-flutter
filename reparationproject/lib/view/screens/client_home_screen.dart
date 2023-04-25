import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import '../../constants/constant.dart';
import '../../main.dart';
import '../widgets/client_home_components/appointment.dart';
import '../widgets/client_home_components/custom_navigation_bar.dart';
import '../widgets/client_home_components/custom_pageview.dart';
import '../widgets/client_home_components/fav.dart';
import '../widgets/client_home_components/home.dart';
import '../widgets/client_home_components/language.dart';
import '../widgets/client_home_components/wallet.dart';
import 'client_sign_in_screen.dart';
import '../widgets/client_home_components/mail.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MaterialApp(home: ClientHomeScreen()));

class ClientHomeScreen extends StatefulWidget {
  @override
  _ClientHomeScreenState createState() => _ClientHomeScreenState();
}

class _ClientHomeScreenState extends State<ClientHomeScreen> {
  GlobalKey<CurvedNavigationBarState> bottomNavigationKey = GlobalKey();
  int page = 0;
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: goldColor.withOpacity(0.6),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return CLanguage();
                  },
                ),
              );
            },
            child: Container(
              margin: EdgeInsets.only(right: 15, left: 15),
              child: Icon(
                Icons.language,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            width: 280,
          ),
          GestureDetector(
            onTap: () {
              sharedPref.clear();
              print(
                sharedPref.getString('token'),
              );
         Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => ClientSignInScreen(),), (route) => false);
            },
            child: Container(
              margin: EdgeInsets.only(right: 15, left: 15),
              child: Icon(
                Icons.logout_sharp,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        key: bottomNavigationKey,
        index: page,
        height: 60.0,
        items: <Widget>[
          Icon(Icons.account_balance_wallet_rounded,
              size: 30, color: Colors.white70),
          Icon(
            Icons.mail,
            size: 30,
            color: Colors.white70,
          ),


             Icon(Icons.home, size: 30, color: Colors.white70),
        Icon(
              Icons.date_range,
              size: 30,
              color: Colors.white70,
            ),

          Icon(Icons.favorite, size: 30, color: Colors.pink),
        ],
        color: goldColor.withOpacity(0.6),
        buttonBackgroundColor: goldColor.withOpacity(0.6),
        backgroundColor: Colors.grey.shade200,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 600),
        onTap: (index) {
          setState(() {
            page = index;
            pageController.animateToPage(page,
                duration: Duration(milliseconds: 750),
                curve: Curves.linearToEaseOut);
          });
        },
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 660,
              width: 500,
              child: PageView(
                controller: pageController,
                onPageChanged: (page) {
                  setState(() {
                    page = page;
                  });
                },
                physics: NeverScrollableScrollPhysics(),
                children: [
                  CMyWallet(),
                  // Language(),
                  CMail(),
                  Home(),
                  CAppointments(),
                  Fav(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
