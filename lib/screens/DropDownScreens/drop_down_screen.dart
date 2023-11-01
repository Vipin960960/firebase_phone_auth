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
              const SizedBox(height: 30,),
              TextFormField(
                  // controller: _mobileNumberController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter service name",
                    prefixIcon:  const Icon(Icons.search),
                    prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
                    hintStyle: customTextStyle.getTextStyleRegular(fontSize: 18, fontColor: greyColor),
                  ),
                  readOnly: false,
                  keyboardType: TextInputType.text,
                  onChanged: (value) {
                    searchItemsModelList = filterItems(value);
                    setState(() {});
                  },
              ),
              SingleChildScrollView(
                child: ListView(
                  children: List.generate(searchItemsModelList.length, (index) {
                    return Row(
                      children: [
                        Image.asset(searchItemsModelList[index].imagePath,width: 40,height: 40,),
                        const SizedBox(width: 10,),
                        Text(searchItemsModelList[index].title)
                      ],
                    );
                  }),
                  ),
              ),
            ],
          )
      ),
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
      if(title){
        return true;
      }else{
        return false;
      }
    });

    return filterList;
  }


}
