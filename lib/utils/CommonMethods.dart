import 'package:firebase_phone_auth/utils/styles.dart';
import 'package:firebase_phone_auth/utils/text_styles.dart';
import 'package:flutter/material.dart';

class CommonMethods{

  CustomTextStyle customTextStyle = CustomTextStyle();

  void showErrorDialog(BuildContext context,errorMsg) async{
    await showGeneralDialog(
      barrierLabel: "Label",
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration:
      const Duration(milliseconds: 400),
      context: context,
      pageBuilder: (context, anim1, anim2) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: whiteColor.withOpacity(0.1),
            body: Center(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.white,
                    borderRadius:
                    BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black,
                          offset: Offset(0, 10),
                          blurRadius: 10),
                    ]),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      "Error",
                      style: customTextStyle
                          .getTextStyleBold(
                          fontSize: 22,
                          fontColor: blueColor),
                      textAlign: TextAlign.center,
                      textScaleFactor: 1.0,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      errorMsg.toString(),
                      style: customTextStyle
                          .getTextStyleMedium(
                          fontSize: 14,
                          fontColor: blackColor),
                      textAlign: TextAlign.center,
                      textScaleFactor: 1.0,
                    ),
                    const SizedBox(height: 20),
                    Align(
                      alignment:
                      Alignment.bottomCenter,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 30,
                          width: 80,
                          child: Text(
                            "OK",
                            textAlign: TextAlign.center,
                            style: customTextStyle
                                .getTextStyleRegular(
                                fontSize: 18,
                                fontColor:
                                whiteColor),
                            textScaleFactor: 1.0,
                          ),
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius:
                            const BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      transitionBuilder:
          (context, anim1, anim2, child) {
        return SlideTransition(
          position: Tween(
            begin: const Offset(0, 1),
            end: const Offset(0, 0),
          ).animate(anim1),
          child: child,
        );
      },
    );

  }

}