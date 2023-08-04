import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:singleclinic/screens/doctor_clinic/custom_drawer.dart';
import 'package:singleclinic/screens/doctor_clinic/doctor_appointment_screen/doctor_appointment_screen.dart';
import 'package:singleclinic/screens/doctor_clinic/doctor_dashboard_screen/components/custom_data_table.dart';
import 'package:singleclinic/utils/colors.dart';

class DoctorDashboardScreen extends StatefulWidget {
  const DoctorDashboardScreen({Key key}) : super(key: key);
  static String routeName = "doctorDashboardScreen";
  @override
  State<DoctorDashboardScreen> createState() => _DoctorDashboardScreenState();
}

class _DoctorDashboardScreenState extends State<DoctorDashboardScreen> {

  List<DataColumn> latestAppointmentDataCols = [
    DataColumn(
        label: Text(
          "ID",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18
          ),
        )
    ),
    DataColumn(
        label: Text(
          "Patient Name",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18
          ),
        )
    ),
    DataColumn(
        label: Text(
          "Department Name",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18
          ),
        )
    ),
    DataColumn(
        label: Text(
          "Service Name",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18
          ),
        )
    )
  ];

  List<DataRow> latestAppointmentDataRows = [
    DataRow(cells: [
      DataCell(Text('1')),
      DataCell(Text('Dr. Stephen')),
      DataCell(Text('Actor')),
      DataCell(Text('Urology')),

    ]),
    DataRow(cells: [
      DataCell(Text('2')),
      DataCell(Text('John')),
      DataCell(Text('Student')),
      DataCell(Text('Cardiology')),

    ]),
    DataRow(cells: [
      DataCell(Text('3')),
      DataCell(Text('Harry')),
      DataCell(Text('Leader')),
      DataCell(Text('Urology')),

    ]),
    DataRow(cells: [
      DataCell(Text('4')),
      DataCell(Text('Peter')),
      DataCell(Text('Scientist')),
      DataCell(Text('Cardiology')),
    ]),
  ];

  List<DashboardCategory> dashboardCategories = [
    DashboardCategory(
        categoryName: "Total Appointment",
        categoryIcon: Icon(
          CupertinoIcons.doc_person, color: Colors.blueAccent,),
        categoryColor: Colors.blueAccent,
        categoryData: 11
    ),
    DashboardCategory(
        categoryName: "Complete Appointment",
        categoryIcon: Icon(CupertinoIcons.doc_append, color: Colors.green,),
        categoryColor: Colors.green,
        categoryData: 13
    ),
    DashboardCategory(
        categoryName: "Pending Appointment",
        categoryIcon: Icon(CupertinoIcons.book, color: Colors.amber,),
        categoryColor: Colors.amber,
        categoryData: 7
    ),
  ];

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    var screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
        backgroundColor: primaryColor,
        centerTitle: true,
      ),
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: screenWidth / 10,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                height: 200,
                child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: dashboardCategories.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 15, bottom: 15),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                              color: Colors.white,
                              boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade300,
                                blurRadius: 7,
                                offset: Offset(3,3)
                              )
                            ]
                          ),
                          width: screenWidth / 2.33,
                          padding: EdgeInsets.symmetric(vertical: 15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                height: screenWidth / 5,
                                width: screenWidth / 5,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(
                                        color: dashboardCategories[index]
                                            .categoryColor
                                    )
                                ),
                                child: dashboardCategories[index].categoryIcon,
                              ),
                              Text(
                                dashboardCategories[index].categoryName,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: screenWidth / 25
                                ),
                              ),
                              Text(dashboardCategories[index].categoryData
                                  .toString()),
                            ],
                          ),
                        ),
                      );
                    },

                ),
              ),
            ),
            SizedBox(height: screenWidth / 10,),
            customDataTable(
              tableName: "Upcoming Appointments",
              context: context,
              dataTableColumns: latestAppointmentDataCols,
              dataTableRows: latestAppointmentDataRows,
              hasShowAll: true,
              routeName: DoctorAppointmentScreen.routeName
            ),
            SizedBox(height: screenWidth / 10,),
          ],
        ),
      ),
    );
  }
}


class DashboardCategory {
  String categoryName;
  Icon categoryIcon;
  Color categoryColor;
  var categoryData;

  DashboardCategory({
    this.categoryName,
    this.categoryIcon,
    this.categoryColor,
    this.categoryData});
}
