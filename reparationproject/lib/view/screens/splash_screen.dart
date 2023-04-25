
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:reparationproject/view/screens/select_user_type_screen.dart';
import 'package:splash_view/source/presentation/pages/pages.dart';
import 'package:splash_view/source/presentation/presentation.dart';

import '../../main.dart';
import 'client_home_screen.dart';
import 'expert_home_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SplashView(
      backgroundImageDecoration: BackgroundImageDecoration(
          image: AssetImage('assets/images/splash_bg.png')),
      loadingIndicator:
          LoadingAnimationWidget.prograssiveDots(color: Colors.white, size: 50),
      duration: Duration(seconds: 4),
      done: sharedPref.getString('token') == null
          ? Done(SelectUserTypeScreen(),
              animationDuration: Duration(seconds: 1), curve: Curves.ease)
          : sharedPref.getString == 0
              ? Done(ClientHomeScreen(),
                  animationDuration: Duration(seconds: 1), curve: Curves.ease)
              : Done(ExpertHomeScreen(),
                  animationDuration: Duration(seconds: 1), curve: Curves.ease),
      showStatusBar: false,
      title: Text(
        'Consulto',
        style: TextStyle(
            color: Colors.white,
            fontSize: 40,
            fontWeight: FontWeight.bold,
            fontFamily: 'logo'),
      ),
      bottomLoading: true,
    );
  }
}
