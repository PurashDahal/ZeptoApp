import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:singleclinic/common/widgets/LazyLoaderFooter.dart';
import 'package:singleclinic/modals/hospital_model.dart';
import 'package:singleclinic/scoped_models/hospital_scoped_model.dart';
import 'package:singleclinic/screens/hospital/widget/hospital_item_widget_vertical.dart';

import 'hospital_details_screen.dart';

class HospitalListScreen extends StatefulWidget {
  static const routeName = "hospitalList";

  const HospitalListScreen({Key key}) : super(key: key);

  @override
  State<HospitalListScreen> createState() => _HospitalListScreenState();
}

class _HospitalListScreenState extends State<HospitalListScreen> {

  List<Hospital> searchedHospitals;

  TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff6f6f6),
      appBar: AppBar(
        title: Text(
          "Hospitals",
          style: GoogleFonts.poppins().copyWith(color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        // leading: IconButton(
        //   onPressed: () => Navigator.pop(context),
        //   icon: Icon(Icons.arrow_back_ios),
        //   color: Colors.black,
        // ),
      ),
      body: ScopedModel<HospitalScopedModel>(
        model: HospitalScopedModel.instance,
        child: Builder(builder: (context) {
          HospitalScopedModel.of(context).getHospitalList({},isRefresh: true);
          return ScopedModelDescendant<HospitalScopedModel>(
            builder: (context, _, model) {
              if(searchedHospitals?.length != null) {
                return searchedHospitals.length > 0
                  ? SingleChildScrollView(
                    child: Column(
                      children: [
                        searchField(model),
                        ListView.builder(
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) => HospitalItemVertical(
                            hospital: searchedHospitals[index],
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (c)=>HospitalDetailsScreen(hospital: searchedHospitals[index],)));
                            },
                          ),
                          itemCount: searchedHospitals.length,
                        ),
                      ],
                    ),
                  )
                  : Center(
                    child: CircularProgressIndicator(),
                  );
              }
              else {
                print("no earch");
                return model.hospitalList.length > 0
                    ? SmartRefresher(
                    enablePullDown: false,
                    enablePullUp: true,
                    controller: model.hospitalRefreshController,
                    onLoading: model.onReload,
                    footer: LazyLoaderFooter(),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          searchField(model),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) => HospitalItemVertical(
                              hospital: model.hospitalList[index],
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (c)=>HospitalDetailsScreen(hospital: model.hospitalList[index],)));
                              },

                            ),
                            itemCount: model.hospitalList.length,
                          ),
                        ],
                      ),
                    ))
                    : Center(
                  child: CircularProgressIndicator(),
                );
              }

            }
          );
        })
      ),
    );
  }

  searchHospitals(String hospitalName, HospitalScopedModel model) {
    searchedHospitals = [];
    model.hospitalList.forEach((e) {
      if(e.name.toLowerCase().contains(hospitalName.toLowerCase())){
        setState(() {
          searchedHospitals.add(e);
        });
      }
    });
  }
  searchField(HospitalScopedModel model) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 7,
                  offset: Offset(3,3)
              )
            ]
        ),
        child: TextField(
          controller: searchController,
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none
              )
          ),
          onSubmitted: (value) {
            searchHospitals(value, model);
          },
        ),
      ),
    );

  }

}
