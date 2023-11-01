
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/assetsUrl.dart';
import '../utils/preference_utils.dart';
import '../utils/preferences.dart';
import 'dashboard_screen.dart';
import 'otpVarification/carousel_screen.dart';
import 'otpVarification/otp_enter_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key, required this.title});

  final String title;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    PreferenceUtils.init();
    Future.delayed(const Duration(seconds: 2)).then((value){
      if(Preferences.getUserUid()==""){
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => CarouselScreen(title: "Carousel")),
                (Route<dynamic> routes)=>false
        ).then((value){
          SystemNavigator.pop();
        });
        // builder: (context) => OTPEnterScreen(verificationId: "29j9je9je939ej39e3"))
        // builder: (context) => CarouselScreen(title: "Carousel"))
      }else{
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => DashboardScreen(title: "Dashboard")),
                (Route<dynamic> routes)=>false
        ).then((value){
          SystemNavigator.pop();
        });
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Image.asset(rocketLaunch);
  }
}
