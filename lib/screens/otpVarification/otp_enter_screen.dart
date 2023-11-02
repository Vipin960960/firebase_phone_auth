import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../utils/preferences.dart';
import '../../utils/styles.dart';
import '../../utils/text_styles.dart';
import '../dashboard_screen.dart';

class OTPEnterScreen extends StatefulWidget {
  final String verificationId;

  OTPEnterScreen({required this.verificationId});

  @override
  State<OTPEnterScreen> createState() => _OTPEnterScreenState();
}

class _OTPEnterScreenState extends State<OTPEnterScreen> {
  int activeIndex = 0;

  List<Widget> carouselItems = [];
  FirebaseAuth auth = FirebaseAuth.instance;
  CustomTextStyle customTextStyle = CustomTextStyle();
  int resendTimer =60;
  bool canNavigateNow = false;

  @override
  Widget build(BuildContext context) {
    return enterOtpUi(context);
  }

  Widget enterOtpUi(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: shadowColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 30,),
            Center(child: Text("Enter your phone number",style: customTextStyle.getTextStyleBold(fontSize: 20, fontColor: blackColor),textAlign: TextAlign.center,)),
            const SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.fromLTRB(15,8,15,8),
              child: Text("The quick, brown fox jumps over a lazy dog, Djs flock by",style: customTextStyle.getTextStyleRegular(fontSize: 16, fontColor: greyColor),textAlign: TextAlign.center,),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 30, 0, 30),
              child: Pinput(
                length: 6,
                showCursor: true,
                defaultPinTheme: PinTheme(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(13),
                  ),
                ),
                onChanged: (value) async {
                  print(value);
                  if(value.length==6){
                    PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: widget.verificationId, smsCode: value);
                    UserCredential data = await auth.signInWithCredential(credential);

                    Preferences.setUserUid(data.user!.uid);
                    print("User Uid is: ${data.user!.uid}");

                    setState(() {
                      canNavigateNow = true;
                    });
                  }
                },
              ),
            ),

            Row(
              children: [
                const Spacer(),
                GestureDetector(
                  onTap: () async {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => DashboardScreen(title: "Dashboard")),
                            (Route<dynamic> routes)=>false
                    ).then((value){
                      SystemNavigator.pop();
                    });
                  },
                  child: Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(35, 5, 35, 5),
                    margin: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: canNavigateNow?blackColor:greyColor
                    ),
                    child: Center(child: Text("NEXT",style: customTextStyle.getTextStyleRegular(fontSize: 20, fontColor: whiteColor),)),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 40,),

            Container(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0,10,0,10),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            text: "Send code again",
                          style: customTextStyle.getTextStyleRegular(
                              fontSize: 16, fontColor: textPrimaryColor.withOpacity(0.5)),
                          children: [
                            TextSpan(
                              text: "(${resendTimer})",
                              style: customTextStyle.getTextStyleMedium(
                                  fontSize: 16, fontColor: blueColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],),
            ),

            GestureDetector(
              onTap: (){
                Navigator.of(context).pop("ChangeTxt");
              },
              child: Text("Change phone number",style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w400,
                    color: primaryColor,
                    decoration: TextDecoration.underline,
                ),),
            ),
          ],
        )
      ),
    );
  }

}
