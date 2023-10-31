
import 'package:flutter/material.dart';

import '../utils/assetsUrl.dart';
import '../utils/preference_utils.dart';
import '../utils/preferences.dart';
import 'dashboard_screen.dart';
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
    // Preferences.setUserUid("Hello");
    Future.delayed(const Duration(seconds: 2)).then((value){
      if(Preferences.getUserUid()==""){
        print("If ${Preferences.getUserUid()}");
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => OTPEnterScreen(verificationId: "29j9je9je939ej39e3")),
                (Route<dynamic> routes)=>false
        );
                // builder: (context) => CarouselScreen(title: "Carousel"))
      }else{
        print("Else ${Preferences.getUserUid()}");
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => DashboardScreen(title: "Dashboard")),
                (Route<dynamic> routes)=>false
        );
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Image.asset(rocketLaunch)
    );
  }
}
