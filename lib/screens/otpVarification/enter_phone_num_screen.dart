import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_phone_auth/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils/CommonMethods.dart';
import '../../utils/assetsUrl.dart';
import '../../utils/text_styles.dart';
import '../../utils/validation.dart';
import 'Otp_enter_screen.dart';

class EnterPhoneNumScreen extends StatefulWidget {
  final String title;

  EnterPhoneNumScreen({required this.title});

  @override
  State<EnterPhoneNumScreen> createState() => _EnterPhoneNumScreenState();
}

class _EnterPhoneNumScreenState extends State<EnterPhoneNumScreen> {
  int activeIndex = 0;
  final _mobileNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool acceptTermAndCondition = false;
  bool rValue = true;
  List<Widget> carouselItems = [];
  FirebaseAuth auth = FirebaseAuth.instance;

  CustomTextStyle customTextStyle = CustomTextStyle();
  CommonMethods commonMethods = CommonMethods();
  bool hideNextButton = false;

  @override
  Widget build(BuildContext context) {
    final scaleFactor = MediaQuery.of(context).textScaleFactor;

    return enterPhoneUi(context, scaleFactor);
  }

  Widget enterPhoneUi(BuildContext context, scaleFactor) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: shadowColor,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              Center(
                  child: Text(
                "Enter your phone number",
                style: customTextStyle.getTextStyleBold(
                    fontSize: 20, fontColor: blackColor),
                textAlign: TextAlign.center,
              )),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
                child: Text(
                  "The quick, brown fox jumps over a lazy dog, Djs flock by",
                  style: customTextStyle.getTextStyleRegular(
                      fontSize: 16, fontColor: greyColor),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: whiteColor, borderRadius: BorderRadius.circular(13)),
                margin: const EdgeInsets.fromLTRB(15, 20, 15, 0),
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: Form(
                  key: _formKey,
                  child: TextFormField(
                      controller: _mobileNumberController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Enter mobile number",
                        prefixIcon: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              indiaCountryImage,
                              width: 30,
                              height: 30,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              "+91",
                              style: customTextStyle.getTextStyleMedium(
                                  fontSize: 17, fontColor: blackColor),
                            ),
                            VerticalDivider(
                              color: shadowColor,
                            )
                          ],
                        ),
                        prefixIconConstraints:
                            const BoxConstraints(minWidth: 0, minHeight: 0),
                        hintStyle: customTextStyle.getTextStyleRegular(
                            fontSize: 18, fontColor: greyColor),
                      ),
                      readOnly: false,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(10),
                      ],
                      onChanged: (mobileNumber) {
                        if (mobileNumber.toString().length == 10) {
                          if (_formKey.currentState!.validate()) {
                            FocusManager.instance.primaryFocus?.unfocus();
                          }
                        }
                      },
                      validator: Validation.validMobile),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap:(){
                        setState((){
                          acceptTermAndCondition = !acceptTermAndCondition;
                        });
                      },
                      child: Container(
                        height: 18,
                        width: 18,
                        alignment: Alignment.center,
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(color: blackColor,width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: acceptTermAndCondition?Container(
                          height: 15,
                          width: 15,
                          margin: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: blackColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ):SizedBox(),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                        child: RichText(
                          textAlign: TextAlign.start,
                          text: TextSpan(
                            text: "I have read and agree to the",
                            style: customTextStyle.getTextStyleRegular(
                                fontSize: 16 / scaleFactor,
                                fontColor: greyColor),
                            children: [
                              TextSpan(
                                text: " terms of use",
                                style: customTextStyle.getTextStyleMedium(
                                    fontSize: 16 / scaleFactor,
                                    fontColor: primaryColor),
                              ),
                              TextSpan(
                                text: " of NPAY",
                                style: customTextStyle.getTextStyleRegular(
                                    fontSize: 16 / scaleFactor,
                                    fontColor: greyColor),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  const Spacer(),
                  !acceptTermAndCondition && !hideNextButton
                      ?
                  Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(35, 5, 35, 5),
                    margin: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: greyColor),
                    child: Center(
                        child: Text(
                          "NEXT",
                          style: customTextStyle.getTextStyleRegular(
                              fontSize: 20, fontColor: whiteColor),
                        )),
                  )
                      :
                  GestureDetector(
                    onTap: () async {
                      if (!hideNextButton && _mobileNumberController.text.length>9) {
                        hideNextButton = true;
                        setState(() {});
                        await FirebaseAuth.instance.verifyPhoneNumber(
                          phoneNumber: '+91${_mobileNumberController.text}',
                          verificationCompleted: (PhoneAuthCredential credential) async {},
                          verificationFailed: (FirebaseAuthException e) async {
                            commonMethods.showErrorDialog(context,e.message);
                          },
                          codeSent: (String verificationId, int? resendToken) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => OTPEnterScreen(
                                          verificationId: verificationId,
                                        ))).then((value) {
                              if (value != null) {
                                _mobileNumberController.text = "";
                                setState((){
                                  hideNextButton = false;
                                });
                              }
                            });
                          },
                          codeAutoRetrievalTimeout: (String verificationId) {},
                        );
                      }
                    },
                    child: Container(
                      height: 50,
                      padding: const EdgeInsets.fromLTRB(35, 5, 35, 5),
                      margin: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: !hideNextButton ? blackColor : greyColor),
                      child: Center(
                          child: Text(
                        "NEXT",
                        style: customTextStyle.getTextStyleRegular(
                            fontSize: 20, fontColor: whiteColor),
                      )),
                    ),
                  ),
                ],
              )
            ],
          )),
    );
  }

}
