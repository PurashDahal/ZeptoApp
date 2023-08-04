import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:singleclinic/common/widgets/circle_widget.dart';
import 'package:singleclinic/screens/AppointmentScreen.dart';
import 'package:singleclinic/screens/BookAppointment.dart';
import 'package:singleclinic/screens/LoginScreen.dart';
import 'package:singleclinic/screens/ChatList.dart' as oldChat;
import 'package:singleclinic/screens/appointment/appointment_screen.dart';
import 'package:singleclinic/screens/doctor_clinic/doctor_appointment_screen/doctor_appointment_screen.dart';
import 'package:singleclinic/screens/doctor_clinic/doctor_chat_screen/doctor_chat_screen.dart';
import 'package:singleclinic/screens/doctor_clinic/doctor_dashboard_screen/doctor_dashboard_screen.dart';
import 'package:singleclinic/utils/colors.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  String imageUrl, name;

  @override
  void initState() {
    SharedPreferences.getInstance().then((value) {
      setState(() {
        imageUrl = value.getString("profile_pic");
        name = value.getString("name");
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: primaryColor,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SafeArea(
              child: Container(
                height: 125,
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100)),
                      child: Center(
                        child: imageUrl != "" && imageUrl != null
                          ? Image.network(imageUrl)
                          : Text(
                            name?.characters?.first ?? " ",
                            style: GoogleFonts.poppins().copyWith(fontSize: 19),
                          )
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      name ?? "",
                      style: GoogleFonts.poppins().copyWith(
                          fontSize: 19,
                          color: Colors.white,
                          fontWeight: FontWeight.w700),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                          CupertinoIcons.arrow_right_circle_fill,
                        size: 30,
                        color: Colors.white,
                      )
                    )
                  ],
                )
              ),
            ),
            customDrawerItem(
              icon: Icon(CupertinoIcons.table, size: 17,),
              name: "Dashboard",
              routeName: DoctorDashboardScreen.routeName
            ),
            customDrawerItem(
              icon: Icon(CupertinoIcons.chat_bubble_fill, size: 17,),
              name: "Chats",
              routeName: DoctorChatScreen.routeName
            ),
            customDrawerItem(
              icon: Icon(CupertinoIcons.calendar, size: 17,),
              name: "Appointments",
              routeName: DoctorAppointmentScreen.routeName

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
    );
  }
  customDrawerItem({var routeName, var icon, var name}) {
    return Column(
      children: [
        ListTile(
          onTap:routeName != null
              ? () { Navigator.of(context).pushNamed(routeName);}
              : () {},
          leading: CircleWidget(child: icon ),
          title: Text(
            name,
            style: GoogleFonts.poppins()
                .copyWith(color: Colors.white, fontSize: 17),
          ),
        ),
        SizedBox(
          height: 5,
        ),
      ],
    );
  }


}
