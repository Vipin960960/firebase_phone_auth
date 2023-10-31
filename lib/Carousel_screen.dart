import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CarouselScreen extends StatefulWidget {
  final String title;

  CarouselScreen({required this.title});

  @override
  State<CarouselScreen> createState() => _CarouselScreenState();
}

class _CarouselScreenState extends State<CarouselScreen> {
  int activeIndex = 0;

  List<Widget> carouselItems = [];

  @override
  Widget build(BuildContext context) {
    return carouselScreenUi(context);
  }

  Widget carouselScreenUi(BuildContext context) {
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
                  // PageView(
                  //   // scrollDirection: Axis.vertical,
                  //   onPageChanged: (index){
                  //     print("Page ${index+1}");
                  //   },
                  //   children: [
                  //     Container(
                  //       height: 500,
                  //       color: Colors.red,
                  //       child: const Center(child: Text("Page 1"),),
                  //     ),
                  //     Container(
                  //       height: 500,
                  //       color: Colors.green,
                  //       child: const Center(child: Text("Page 2"),),
                  //     ),
                  //     Container(
                  //       height: 500,
                  //       color: Colors.grey,
                  //       child: const Center(child: Text("Page 3"),),
                  //     )
                  //   ],
                  // ),
                  CarouselSlider.builder(
                    options: CarouselOptions(
                        height: 500,
                        // autoPlay: true,
                        // enlargeCenterPage: true,
                        onPageChanged: (index, _) {
                          setState(() {
                            activeIndex = index;
                          });
                        }),
                    itemCount: carouselItems.length,
                    itemBuilder: (BuildContext context, int index, int realIndex) {
                      return GestureDetector(
                        onTap: () {
                        },
                        child: getCarouselItem(context,index)
                      );
                    },
                  ),
                  const SizedBox(height: 32),
                  AnimatedSmoothIndicator(
                    activeIndex: activeIndex,
                    count: carouselItems.length,
                    duration: const Duration(microseconds: 700),
                    effect: const ScrollingDotsEffect(
                        dotHeight: 10, dotWidth: 10, activeDotColor: Colors.blue),
                  ),
                ],
              )
      ),
    );
  }

  getCarouselItem(context,index) {
    if(carouselItems.isEmpty){
      carouselItems.add(Container(
        width: MediaQuery.of(context).size.width,
        height: 400,
        color: Colors.green,
      ));
      carouselItems.add(Container(
        width: MediaQuery.of(context).size.width,
        height: 400,
        color: Colors.red,
      ));
      carouselItems.add(Container(
        width: MediaQuery.of(context).size.width,
        height: 400,
        color: Colors.blue,
      ));
    }

    return carouselItems[index];
  }
}
