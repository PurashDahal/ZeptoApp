import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:singleclinic/order/order_screen.dart';
import 'package:singleclinic/screens/AppointmentScreen.dart';
import 'package:singleclinic/screens/BookAppointment.dart';
import 'package:singleclinic/screens/ChatList.dart';
import 'package:singleclinic/screens/ContactUsScreen.dart';
import 'package:singleclinic/screens/LoginScreen.dart';
import 'package:singleclinic/screens/SubcriptionList.dart';
import 'package:singleclinic/screens/TermAndConditions.dart';
import 'package:singleclinic/screens/department/department_screen.dart';
import 'package:singleclinic/screens/doctors/doctors_list_screen.dart';
import 'package:singleclinic/screens/shop/shop_screen.dart';
import 'package:singleclinic/utils/colors.dart';
import 'package:singleclinic/screens/web_view.dart';

import 'circle_widget.dart';


class DrawerWidget extends StatefulWidget {
  const DrawerWidget({Key key}) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  String imageUrl, name, phoneNum;
  String becomeASellerUrl = "https://sansarhealth.com/become-a-seller";
  String becomeOurHealthPartnerUrl = "https://sansarhealth.com/become-a-health-partner";
  String becomeOurDoctorUrl = "https://sansarhealth.com/become-a-doctor";


  @override
  void initState() {
    SharedPreferences.getInstance().then((value) {
      setState(() {
        imageUrl = value.getString("profile_pic");
        name = value.getString("name");
        phoneNum = value.getString("phone_no");
      });
    });
    super.initState();
  }
  void handleWebViews(BuildContext context, String url) {
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => WebViewContainer(url)));
  }


  @override
  Widget build(BuildContext context) {
    return  Drawer(
      child: Container(
        color: primaryColor,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100)),
                      child: Center(
                          child: Text(
                            name?.characters?.first ?? " ",
                            style: GoogleFonts.poppins().copyWith(fontSize: 19),
                          )),
                    ),
                    SizedBox(width: 10),
                    Column(
                      children: [
                        Text(
                          name ?? "",
                          style: GoogleFonts.poppins().copyWith(
                              fontSize: 19,
                              color: Colors.white,
                              fontWeight: FontWeight.w700),
                        ),
                        Text(
                          phoneNum ?? "",
                          style: GoogleFonts.poppins().copyWith(
                              fontSize: 19,
                              color: Colors.white.withOpacity(0.7)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),

              ListTile(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (c)=>BookAppointment()));
                },
                leading: CircleWidget(child: Icon(CupertinoIcons.archivebox, size: 17,)),
                title: Text(
                  "Book Appointment At Hospital",
                  style: GoogleFonts.poppins()
                      .copyWith(color: Colors.white, fontSize: 17),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).pushNamed(DoctorsListScreen.routeName);
                },
                leading: CircleWidget(child: Icon(CupertinoIcons.person, size: 17,)),
                title: Text(
                  "Our Doctors",
                  style: GoogleFonts.poppins()
                      .copyWith(color: Colors.white, fontSize: 17),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).pushNamed(DepartmentListScreen.routeName);
                },
                leading: CircleWidget(child: Icon(CupertinoIcons.group, size: 17,)),
                title: Text(
                  "Our Departments",
                  style: GoogleFonts.poppins()
                      .copyWith(color: Colors.white, fontSize: 17),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              ListTile(
                onTap: () => Navigator.of(context).pushNamed(ShopScreen.routeName),
                leading: CircleWidget(child: Icon(CupertinoIcons.capsule, size: 17,)),
                title: Text(
                  "Medicine",
                  style: GoogleFonts.poppins()
                      .copyWith(color: Colors.white, fontSize: 17),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              ListTile(
                onTap: () => Navigator.of(context).pushNamed(ContactUsScreen.routeName),
                leading: CircleWidget(child: Icon(CupertinoIcons.phone, size: 17,)),
                title: Text(
                  "Contact",
                  style: GoogleFonts.poppins()
                      .copyWith(color: Colors.white, fontSize: 17),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              ListTile(
                onTap: () => Navigator.of(context).pushNamed(TermAndConditions.routeName),
                leading: CircleWidget(child: Icon(CupertinoIcons.doc, size: 17,)),
                title: Text(
                  "Terms & Condition",
                  style: GoogleFonts.poppins()
                      .copyWith(color: Colors.white, fontSize: 17),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              ListTile(
                onTap: () =>
                    handleWebViews(context, becomeASellerUrl),

                leading: CircleWidget(child: Icon(CupertinoIcons.bag, size: 17,)),
                title: Text(
                  "Become a Seller",
                  style: GoogleFonts.poppins()
                      .copyWith(color: Colors.white, fontSize: 17),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              ListTile(
                onTap: () => handleWebViews(context, becomeOurHealthPartnerUrl),
                leading: CircleWidget(child: Icon(Icons.health_and_safety_outlined, size: 17,)),
                title: Text(
                  "Become our Health Partner",
                  style: GoogleFonts.poppins()
                      .copyWith(color: Colors.white, fontSize: 17),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              ListTile(
                onTap: () => handleWebViews(context, becomeOurDoctorUrl),
                leading:
                CircleWidget(child: Icon(CupertinoIcons.heart, size: 17,)),
                title: Text(
                  "Become our Doctor",
                  style: GoogleFonts.poppins()
                      .copyWith(color: Colors.white, fontSize: 17),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              ListTile(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (c)=> SubcriptionList()))
                ,
                leading: CircleWidget(child: Icon(CupertinoIcons.phone, size: 17,)),
                title: Text(
                  "My Subscriptions",
                  style: GoogleFonts.poppins()
                      .copyWith(color: Colors.white, fontSize: 17),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              ListTile(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AppointmentScreen(),
                    )
                ),
                leading: CircleWidget(child: Icon(CupertinoIcons.phone, size: 17,)),
                title: Text(
                  "My Appointments",
                  style: GoogleFonts.poppins()
                      .copyWith(color: Colors.white, fontSize: 17),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              ListTile(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrderScreen(),
                    )
                ),
                leading: CircleWidget(child: Icon(CupertinoIcons.phone, size: 17,)),
                title: Text(
                  "My Orders",
                  style: GoogleFonts.poppins()
                      .copyWith(color: Colors.white, fontSize: 17),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              ListTile(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatList(),
                    )
                ),
                leading: CircleWidget(child: Icon(CupertinoIcons.phone, size: 17,)),
                title: Text(
                  "Chats",
                  style: GoogleFonts.poppins()
                      .copyWith(color: Colors.white, fontSize: 17),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              SizedBox(
                height: 8,
              ),
              InkWell(
                onTap: ()async{
                  var shared=await  SharedPreferences.getInstance();
                  shared.setBool("isLoggedIn", false);
                  Navigator.push(context, MaterialPageRoute(builder: (c)=>LoginScreen()));
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(10),
                  child: Center(
                      child: Text(
                        "Logout",
                        style: GoogleFonts.poppins().copyWith(color: primaryColor),
                      )),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
