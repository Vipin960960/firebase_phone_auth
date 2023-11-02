import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_phone_auth/utils/assetsUrl.dart';
import 'package:firebase_phone_auth/utils/preference_utils.dart';
import 'package:firebase_phone_auth/utils/styles.dart';
import 'package:firebase_phone_auth/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/dashboard/service_model.dart';
import 'DropDownScreens/drop_down_screen.dart';
import 'otpVarification/carousel_screen.dart';

class DashboardScreen extends StatefulWidget {
  final String title;

  DashboardScreen({required this.title});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  CustomTextStyle customTextStyle = CustomTextStyle();
  List<DashboardItemsModel> gridItemsList = [];
  int? _tabIndex=0;

  final ScrollController _controller = ScrollController();
  bool _isVisible = true;

  @override
  void initState() {
    super.initState();

    _controller.addListener(() {
      if (_controller.position.pixels == 0) {
        setState(() {
          _isVisible = true;
        });
      } else if (_controller.position.pixels>50) {
        setState(() {
          _isVisible = false;
        });
      }
    });

    gridItemsList.add(DashboardItemsModel(iconTransfer, "Transfer"));
    gridItemsList.add(DashboardItemsModel(iconRequestMoneyTransfer, "Request Money Transfer"));
    gridItemsList.add(DashboardItemsModel(iconManageGroupFriends, "Manage group of friends"));
    gridItemsList.add(DashboardItemsModel(iconOrderFood, "Order food online"));
    gridItemsList.add(DashboardItemsModel(iconGiveGift, "Give gift"));
    gridItemsList.add(DashboardItemsModel(iconPaybill, "Pay bills"));
    gridItemsList.add(DashboardItemsModel(iconBuyMovieTicket, "Buy movie tickets"));
    gridItemsList.add(DashboardItemsModel(iconCustomerLoan, "Consumer Loans"));
    gridItemsList.add(DashboardItemsModel(iconAllService, "All Services"));
  }

  @override
  Widget build(BuildContext context) {
    dynamic _width = MediaQuery.of(context).size.width;
    dynamic _height = MediaQuery.of(context).size.height;
    return dashboardScreenUi(context,_width,_height);
  }

  Widget dashboardScreenUi(BuildContext context,_width,_height) {
    return SafeArea(
      child: Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: listBottomNavigationBarItems(),
            // currentIndex: _tabIndex!,
            selectedItemColor: blackColor,
            unselectedItemColor: greyColor.withOpacity(0.5),
            onTap: (int index) {
              setState((){
                _tabIndex = index;
              });
            },
          ),
          body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Container(
                    height: _height,
                    color: shadowColor,
                  ),
                  Container(
                    height: 100,
                    color: darkGrayColor,
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        GestureDetector(
                          onTap: (){
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SearchDropDownScreen(dashboardItemsModelList: gridItemsList,)));

                          },
                          child: Icon(
                            Icons.search,
                            size: 28,
                            color: whiteColor,
                          ),
                        ),
                        (!_isVisible)
                            ?
                          Expanded(child: Row(children: [
                            const Spacer(),
                            Image.asset(iconDeposit,
                                width: 25, height: 25, color: whiteColor),
                            const Spacer(),
                            Image.asset(iconWithdraw,
                                width: 25, height: 25, color: whiteColor),
                            const Spacer(),
                            Image.asset(iconQrCode,
                                width: 22, height: 22, color: whiteColor),
                            const Spacer(),
                            Image.asset(iconScan,
                                width: 25, height: 25, color: whiteColor),
                            const Spacer(),
                            Image.asset(iconbell,
                                width: 25, height: 25, color: whiteColor),
                            const Spacer(),
                          ],))
                            :
                        Expanded(child: Text("  Search",style: customTextStyle.getTextStyleMedium(fontSize: 18, fontColor: greyColor),)),
                        GestureDetector(
                          onTap: (){
                            FirebaseAuth.instance.signOut();
                            PreferenceUtils.clear();
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (context) => CarouselScreen(title: "Carousel")),
                                    (Route<dynamic> routes)=>false
                            ).then((value){
                              SystemNavigator.pop();
                            });
                          },
                          child: Icon(Icons.power_settings_new_rounded,
                              size: 28, color: whiteColor),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 70),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          margin: const EdgeInsets.fromLTRB(15, 0, 15, 5),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(35),
                          ),
                          child: Column(
                            children: [
                              if(_isVisible)
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  children: [
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Image.asset(
                                          iconDeposit,
                                          height: 25,
                                          width: 25,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "Deposit",
                                          style:
                                              customTextStyle.getTextStyleMedium(
                                                  fontSize: 13,
                                                  fontColor: blueColor),
                                        )
                                      ],
                                    ),
                                    const Spacer(),
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Image.asset(
                                          iconWithdraw,
                                          height: 25,
                                          width: 25,
                                          color: Colors.green,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "Withdrawal",
                                          style:
                                              customTextStyle.getTextStyleMedium(
                                                  fontSize: 13,
                                                  fontColor: blueColor),
                                        )
                                      ],
                                    ),
                                    const Spacer(),
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Image.asset(
                                          iconQrCode,
                                          height: 25,
                                          width: 25,
                                          color: orangeColor,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "Pay Code",
                                          style:
                                              customTextStyle.getTextStyleMedium(
                                                  fontSize: 13,
                                                  fontColor: blueColor),
                                        )
                                      ],
                                    ),
                                    const Spacer(),
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Image.asset(
                                          iconScan,
                                          height: 25,
                                          width: 25,
                                          color: purpleColor,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "Scan Code",
                                          style:
                                              customTextStyle.getTextStyleMedium(
                                                  fontSize: 13,
                                                  fontColor: blueColor),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          "Balance in the wallet",
                                          style:
                                              customTextStyle.getTextStyleMedium(
                                                  fontSize: 13,
                                                  fontColor: blackColor),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Image.asset(
                                          iconEye,
                                          height: 25,
                                          width: 25,
                                          color: greyColor,
                                        ),
                                      ],
                                    )),
                                    Text(
                                      "\$ 40.000",
                                      style: customTextStyle.getTextStyleBold(
                                          fontSize: 13, fontColor: blackColor),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: CustomScrollView(
                            controller: _controller,
                            slivers: <Widget>[
                              SliverPadding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0.0),
                                sliver: SliverList(
                                  delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
                                      if(index==0){
                                        return Container(
                                          padding: const EdgeInsets.all(15),
                                          child: GridView.builder(
                                            padding: const EdgeInsets.only(top: 10, bottom: 5),
                                            physics: const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: gridItemsList.length,
                                            gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 3,
                                                childAspectRatio: 1 / 1,
                                                crossAxisSpacing: 10,
                                                mainAxisSpacing: 10),
                                            itemBuilder: (context, index) {
                                              return Container(
                                                padding: const EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                    color: whiteColor,
                                                    borderRadius: BorderRadius.circular(20)),
                                                child: dashboardGridItem(
                                                    gridItemsList[index].imagePath,
                                                    gridItemsList[index].title),
                                              );
                                            },
                                          ),
                                        );
                                      }else if(index==1){
                                        return Container(
                                          padding: const EdgeInsets.only(left: 15),
                                          height: 80,
                                          child: ListView(
                                            scrollDirection: Axis.horizontal,
                                            children: List.generate(4, (index) {
                                              return Card(
                                                  borderOnForeground: false,
                                                  elevation: 0,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(20.0),
                                                  ),
                                                  child: ClipRRect(
                                                      borderRadius: BorderRadius.circular(20.0),
                                                      child: Image.asset(iconSalesOf30,))
                                              );
                                            }),
                                          ),
                                        );
                                      }else if(index ==2){
                                        return Container(
                                          padding: const EdgeInsets.all(15),
                                          child: GridView.builder(
                                            padding: const EdgeInsets.only(top: 10, bottom: 5),
                                            physics: const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: gridItemsList.length,
                                            gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 3,
                                                childAspectRatio: 1 / 1,
                                                crossAxisSpacing: 10,
                                                mainAxisSpacing: 10),
                                            itemBuilder: (context, index) {
                                              return Container(
                                                padding: const EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                    color: whiteColor,
                                                    borderRadius: BorderRadius.circular(20)),
                                                child: dashboardGridItem(
                                                    gridItemsList[index].imagePath,
                                                    gridItemsList[index].title),
                                              );
                                            },
                                          ),
                                        );
                                      }
                                    },
                                    childCount: 3,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        )),
    );
  }

  Widget dashboardGridItem(imagePath, title) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          imagePath,
          height: 35,
          width: 35,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          title,
          textAlign: TextAlign.center,
          style: customTextStyle.getTextStyleRegular(
              fontSize: 12, fontColor: greyColor),
        )
      ],
    );
  }

  List<BottomNavigationBarItem> listBottomNavigationBarItems() {
    List<BottomNavigationBarItem> itemsList = [
      const BottomNavigationBarItem(
        icon: Icon(Icons.paypal),
        label: '',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.replay_sharp),
        label: '',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.account_balance_rounded),
        label: '',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.wallet),
        label: '',
      ),
    ];

    return itemsList;
  }

}


