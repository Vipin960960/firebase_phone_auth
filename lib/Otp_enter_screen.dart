import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OTPEnterScreen extends StatefulWidget {
  final String title;

  OTPEnterScreen({required this.title});

  @override
  State<OTPEnterScreen> createState() => _OTPEnterScreenState();
}

class _OTPEnterScreenState extends State<OTPEnterScreen> {
  int activeIndex = 0;

  List<Widget> carouselItems = [];

  @override
  Widget build(BuildContext context) {
    return importantNoticeUi(context);
  }

  Widget importantNoticeUi(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.blue,
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: const Icon(Icons.arrow_back, color: Colors.white),
              ),
              const SizedBox(width: 5),
              Text(
                widget.title,
                textScaleFactor: 1.0,
                maxLines: null,
              ),
            ],
          ),
        ),
        body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Pinput(
                    length: 6,
                    showCursor: true,
                    onChanged: (value){
                      print(value);
                    },
                  )
                ],
              )
      ),
    );
  }

}
