import 'package:firebase_phone_auth/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../models/dashboard/service_model.dart';
import '../../utils/text_styles.dart';

class SearchDropDownScreen extends StatefulWidget {
  List<DashboardItemsModel> dashboardItemsModelList = [];

  SearchDropDownScreen({required this.dashboardItemsModelList});

  @override
  State<SearchDropDownScreen> createState() => _SearchDropDownScreenState();
}

class _SearchDropDownScreenState extends State<SearchDropDownScreen> {
  List<DashboardItemsModel> searchItemsModelList = [];

  CustomTextStyle customTextStyle = CustomTextStyle();

  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchItemsModelList = widget.dashboardItemsModelList;
  }

  @override
  Widget build(BuildContext context) {
    return searchUI(context);
  }

  Widget searchUI(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: shadowColor,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      height: 70,
                      padding: const EdgeInsets.all(10),
                      color: darkGrayColor,
                      child: Column(children: [
                        TextFormField(
                          controller: _searchController,
                          style: TextStyle(color: whiteColor),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Enter service name",
                            prefixIcon: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.search,color: whiteColor,),
                                const SizedBox(width: 10,)
                              ],
                            ),
                            suffixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
                            suffixIcon: GestureDetector(
                              onTap: (){
                                if(_searchController.text.isEmpty){
                                  Navigator.of(context).pop();
                                }else{
                                  _searchController.text = "";
                                  searchItemsModelList = widget.dashboardItemsModelList;
                                  setState(() {});
                                }
                              },
                              child: Icon(Icons.close_sharp,color: whiteColor,)),
                            prefixIconConstraints:
                            const BoxConstraints(minWidth: 0, minHeight: 0),
                            hintStyle: customTextStyle.getTextStyleRegular(
                                fontSize: 18, fontColor: greyColor),
                          ),
                          readOnly: false,
                          keyboardType: TextInputType.text,
                          onChanged: (value) {
                            searchItemsModelList = filterItems(value);
                            setState(() {});
                          },
                        ),
                      ],),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 75),
                      color: shadowColor,
                      child: SingleChildScrollView(
                        child: ListView(
                          shrinkWrap: true,
                          children:
                          List.generate(searchItemsModelList.length, (index) {
                            return Container(
                              margin: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                              padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: whiteColor
                              ),
                              child: Row(
                                children: [
                                  Image.asset(
                                    searchItemsModelList[index].imagePath,
                                    width: 40,
                                    height: 40,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(searchItemsModelList[index].title)
                                ],
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            ],
          )),
    );
  }

  List<DashboardItemsModel> filterItems(keyword) {
    List<DashboardItemsModel> filterList = [];
    filterList.addAll(widget.dashboardItemsModelList);
    filterList.retainWhere((element) {
      bool title = element.title
          .toString()
          .toLowerCase()
          .contains(keyword.toString().toLowerCase());
      if (title) {
        return true;
      } else {
        return false;
      }
    });

    return filterList;
  }
}
