import 'package:firebase_phone_auth/screens/otpVarification/carousel_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/assetsUrl.dart';
import '../utils/preference_utils.dart';
import '../utils/preferences.dart';
import 'dashboard_screen.dart';

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
