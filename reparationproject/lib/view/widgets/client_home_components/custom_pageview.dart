
import 'package:flutter/cupertino.dart';
import 'package:reparationproject/view/widgets/client_home_components/wallet.dart';


import 'home.dart';
import 'language.dart';

class CustomPageView extends StatefulWidget {
  const CustomPageView({Key? key}) : super(key: key);

  @override
  State<CustomPageView> createState() => _CustomPageViewState();
}

class _CustomPageViewState extends State<CustomPageView> {
  int currentIndex=0;
  PageController pageController=PageController();
  @override
  Widget build(BuildContext context) {
    return PageView(
      onPageChanged:(page) {
        setState(() {
          currentIndex=page;
        });
      },
      controller:pageController ,
      children: [
        Home(),
        CLanguage(),
        CMyWallet(),
      ],
    );
  }
}
