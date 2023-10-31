import 'package:firebase_phone_auth/utils/assetsUrl.dart';
import 'package:firebase_phone_auth/utils/styles.dart';
import 'package:firebase_phone_auth/utils/text_styles.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  final String title;

  DashboardScreen({required this.title});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  CustomTextStyle customTextStyle = CustomTextStyle();

  @override
  Widget build(BuildContext context) {
    return dashboardScreenUi(context);
  }

  Widget dashboardScreenUi(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: whiteColor,
        body: Container(
          height: 400,
          color: whiteColor,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(indiaCountryImage,height: MediaQuery.of(context).size.width,width: MediaQuery.of(context).size.width,),
              Container(alignment: Alignment.center, padding: const EdgeInsets.all(30),child: Text("Welcome to triazine",style: customTextStyle.getTextStyleBold(fontSize: 20, fontColor: blackColor),)),
              Flexible(child: Text("This will be your wonderful journey",style: customTextStyle.getTextStyleMedium(fontSize: 16, fontColor: greyColor),textAlign: TextAlign.center))
            ],
          ),
        )
      ),
    );
  }


}
