import 'package:firebase_phone_auth/screens/dashboard_screen.dart';
import 'package:firebase_phone_auth/utils/assetsUrl.dart';
import 'package:firebase_phone_auth/utils/styles.dart';
import 'package:firebase_phone_auth/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'enter_phone_num_screen.dart';

class CarouselScreen extends StatefulWidget {
  final String title;

  CarouselScreen({required this.title});

  @override
  State<CarouselScreen> createState() => _CarouselScreenState();
}

class _CarouselScreenState extends State<CarouselScreen> {
  int activeIndex = 0;

  List<Widget> carouselItems = [];

  CustomTextStyle customTextStyle = CustomTextStyle();

  @override
  Widget build(BuildContext context) {
    return carouselScreenUi(context);
  }

  Widget carouselScreenUi(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: whiteColor,
        body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 500,
                    child: PageView(
                      onPageChanged: (index){
                        setState(() {
                          activeIndex = index;
                        });
                      },
                      children: [
                        carouselItem(carouselPage1,"Definitely Safe","Lorem ipsum dolor sit amet consectetur adipisicing elit"),
                        carouselItem(carouselPage2,"Easy Deposit","Lorem ipsum dolor sit amet consectetur adipisicing elit"),
                        carouselItem(carouselPage3,"Quick Transfer","Lorem ipsum dolor sit amet consectetur adipisicing elit"),
                        carouselItem(carouselPage4,"Change Station","Lorem ipsum dolor sit amet consectetur adipisicing elit"),
                        carouselItem(carouselPage5,"FAQ","Lorem ipsum dolor sit amet consectetur adipisicing elit")
                      ],
                    ),
                  ),
                  const SizedBox(height: 42),
                  AnimatedSmoothIndicator(
                    activeIndex: activeIndex,
                    count: 5,
                    duration: const Duration(microseconds: 700),
                    effect: const ScrollingDotsEffect(
                        dotHeight: 10, dotWidth: 10, activeDotColor: Colors.blue),
                  ),

                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: (){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DashboardScreen(title: "Enter Phone")));
                            },
                            child: SizedBox(
                              height: 50,
                              child: Center(child: Text("Dashboard",style: customTextStyle.getTextStyleMedium(fontSize: 20, fontColor: blackColor),)),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: (){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EnterPhoneNumScreen(title: "Enter Phone")));
                            },
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                color: blackColor
                              ),
                              child: Center(child: Text("LOGIN",style: customTextStyle.getTextStyleMedium(fontSize: 20, fontColor: whiteColor),)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30,)
                ],
              )
      ),
    );
  }


  Widget carouselItem(image, title,carouselDecs) {
    return Container(
      height: 400,
      color: whiteColor,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(image,height: MediaQuery.of(context).size.width,width: MediaQuery.of(context).size.width,),
          Container(alignment: Alignment.center, padding: const EdgeInsets.all(30),child: Text(title,style: customTextStyle.getTextStyleBold(fontSize: 20, fontColor: blackColor),)),
          Flexible(child: Text(carouselDecs,style: customTextStyle.getTextStyleMedium(fontSize: 16, fontColor: greyColor),textAlign: TextAlign.center))
        ],
      ),
    );
  }
}
