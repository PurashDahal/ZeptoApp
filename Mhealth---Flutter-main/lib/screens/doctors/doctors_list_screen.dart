import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:singleclinic/common/widgets/LazyLoaderFooter.dart';
import 'package:singleclinic/modals/Doctor_model.dart';
import 'package:singleclinic/scoped_models/doctors_model.dart';
import 'package:singleclinic/screens/appointment/appointment_booking_screen.dart';
import 'package:singleclinic/screens/doctors/widget/doctor_item_widget_vertical.dart';

class DoctorsListScreen extends StatefulWidget {
  static const routeName = "DoctorsListScreen";
  final Map<String, String> filtersMap;

  const DoctorsListScreen({Key key, this.filtersMap}) : super(key: key);

  @override
  State<DoctorsListScreen> createState() => _DoctorsListScreenState();
}

class _DoctorsListScreenState extends State<DoctorsListScreen> {
  
  TextEditingController searchController = TextEditingController();
  List<Doctor> searchedDoctors;
  
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
          "Doctors",
          style: GoogleFonts.poppins().copyWith(color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ScopedModel<DoctorsScopedModel>(
        model: DoctorsScopedModel.instance,
        child: Builder(builder: (context) {
          print("Getting doctors from doctors screen");
          DoctorsScopedModel.of(context).getDoctors(
              widget.filtersMap == null ? <String, String> {} : widget.filtersMap,
              isRefresh: true
          );
          return ScopedModelDescendant<DoctorsScopedModel>(
            builder: (context, _, model) {
              if(searchedDoctors?.length != null) {
                return searchedDoctors.length > 0
                    ? SingleChildScrollView(
                      child: Column(
                        children: [
                          searchField(model),
                          ListView.builder(
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) => DoctorItemVertical(
                              doctor: searchedDoctors[index],
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (c)=>DoctorAppointmentScreen(doctor: searchedDoctors[index],)));
                              },
                            ),
                            itemCount: searchedDoctors.length,
                          ),
                        ],
                      ),
                    )
                    : Center(child: CircularProgressIndicator());
              }
              else {
                return model.doctorsList.length > 0
                    ? SmartRefresher(
                    enablePullDown: false,
                    enablePullUp: true,
                    controller: model.doctorRefreshController,
                    onLoading: model.onFilteredLoad,
                    footer: LazyLoaderFooter(),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          searchField(model),
                          ListView.builder(
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) => DoctorItemVertical(
                              doctor: model.doctorsList[index],
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (c)=>DoctorAppointmentScreen(doctor: model.doctorsList[index],)));
                              },
                            ),
                            itemCount: model.doctorsList.length,
                          ),
                        ],
                      ),
                    ))
                    : Center(child: CircularProgressIndicator());
              }

            }
          );
        })
      ),
    );
  }

  searchDoctors(String doctorName, DoctorsScopedModel model) {
    searchedDoctors = [];
    model.doctorsList.forEach((e) {
      if(e.name.toLowerCase().contains(doctorName.toLowerCase())){
        setState(() {
          searchedDoctors.add(e);
        });
      }
    });
  }

  searchField(DoctorsScopedModel model) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
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
            searchDoctors(value, model);
          },
        ),
      ),
    );

  }
}
