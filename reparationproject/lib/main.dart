
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:reparationproject/view/screens/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'constants/constant.dart';
import 'locale/locale.dart';
import 'locale/locale_controller.dart';


late SharedPreferences sharedPref;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPref = await SharedPreferences.getInstance();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context){
    Get.put(MyLocaleController());
    return GetMaterialApp(
      // initialRoute:
      //     sharedPref.getString('id') == null ? 'select_user_type_screen' : 'client_home_screen',
      debugShowCheckedModeBanner: false,
      title: 'Consultation App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: primaryColor,
        textTheme: Theme.of(context).textTheme.apply(displayColor: textColor),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: TextButton.styleFrom(
            backgroundColor: primaryColor,
            padding: EdgeInsets.all(defaultPadding),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: textFieldBorder,
          enabledBorder: textFieldBorder,
          focusedBorder: textFieldBorder,
        ),
      ),
locale:Get.deviceLocale,
      translations: MyLocale(),
      home:SplashScreen(),
    );
  }
}
