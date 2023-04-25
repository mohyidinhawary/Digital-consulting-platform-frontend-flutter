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
import '../widgets/expert_home_component/appointments.dart';
import '../widgets/expert_home_component/mail.dart';
import '../widgets/expert_home_component/wallet.dart';
import 'client_sign_in_screen.dart';
import '../widgets/client_home_components/mail.dart';

void main() => runApp(MaterialApp(home: ExpertHomeScreen()));

class ExpertHomeScreen extends StatefulWidget {
  @override
  _ExpertHomeScreenState createState() => _ExpertHomeScreenState();
}

class _ExpertHomeScreenState extends State<ExpertHomeScreen> {
  GlobalKey<CurvedNavigationBarState> bottomNavigationKey = GlobalKey();
  int page = 0;
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      resizeToAvoidBottomInset: false,
      extendBody: true,

      bottomNavigationBar: CurvedNavigationBar(
        key: bottomNavigationKey,
        index: page,
        height: 60.0,
        items: <Widget>[
          Icon(Icons.account_balance_wallet_rounded,
              size: 30, color: Colors.white70),
          Icon(Icons.home, size: 30, color: Colors.white70),
          Icon(
            Icons.mail,
            size: 30,
            color: Colors.white70,
          ),

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
              height:730,
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
                  EMyWallet(),
               EAppointments(),
                  EMail(),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
