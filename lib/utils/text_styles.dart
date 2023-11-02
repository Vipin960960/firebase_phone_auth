import 'package:flutter/material.dart';

class CustomTextStyle {
  TextStyle getTextStyleRegular({required double fontSize, required Color fontColor, double? height, Color? backgroundColor}) {
    return TextStyle(
        fontSize: fontSize,
        fontFamily: "Loto",
        fontWeight: FontWeight.w300,
        color: fontColor,
    height: height,
    backgroundColor: backgroundColor);
  }

  TextStyle getTextStyleRegularHyperLink({required double fontSize, required Color fontColor}) {
    return TextStyle(
        fontSize: fontSize,
        decoration: TextDecoration.underline,
        fontFamily: "Loto",
        fontWeight: FontWeight.w400,
        color: fontColor);
  }

  TextStyle getTextStyleMedium({required double fontSize, required Color fontColor, double? height, TextDecoration? textDecoration}) {
    return TextStyle(
        fontSize: fontSize,
        fontFamily: "Loto",
        fontWeight: FontWeight.w400,
        color: fontColor,
    height: height, decoration: textDecoration ?? TextDecoration.none);
  }

  TextStyle getTextStyleSemiBold({required double fontSize, required Color fontColor, double? height}) {
    return TextStyle(
        fontSize: fontSize,
        fontFamily: "Loto",
        fontWeight: FontWeight.w500,
        color: fontColor,
    height: height);
  }


  TextStyle getTextStyleBold({required double fontSize, required Color fontColor}) {
    return TextStyle(
        fontSize: fontSize,
        fontFamily: "Loto",
        fontWeight: FontWeight.w600,
        color: fontColor,);
  }

  TextStyle getTextStyleMediumUnderlined({required double fontSize, required Color fontColor, double? height}) {
    return TextStyle(
        fontSize: fontSize,
        fontFamily: "Loto",
        fontWeight: FontWeight.w500,
        color: fontColor,
        height: height,
        decoration: TextDecoration.underline
    );
  }

}
