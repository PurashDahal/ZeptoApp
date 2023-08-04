import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:singleclinic/modals/appointment_model.dart';
import 'package:singleclinic/scoped_models/appointment_scoped_model.dart';
import 'package:singleclinic/scoped_models/doctor_appointment_scoped_model.dart';
import 'package:singleclinic/screens/doctor_clinic/custom_drawer.dart';
import 'package:singleclinic/screens/doctor_clinic/doctor_dashboard_screen/components/custom_data_table.dart';
import 'package:singleclinic/utils/colors.dart';

class DoctorAppointmentScreen extends StatefulWidget {
  const DoctorAppointmentScreen({Key key}) : super(key: key);
  static String routeName = "doctorAppointmentScreen";

  @override
  State<DoctorAppointmentScreen> createState() => _DoctorAppointmentScreenState();
}

class _DoctorAppointmentScreenState extends State<DoctorAppointmentScreen> {
  TextEditingController searchController;
  Appointment appointment;
  List<DataColumn> appointmentColumns = [
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
          "Department Name",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18
          ),
        )
    ),
    DataColumn(
        label: Text(
          "Doctor Name",
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
          "Timing",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18
          ),
        )
    ),
    DataColumn(
        label: Text(
          "Messages",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18
          ),
        )
    ),
    DataColumn(
        label: Text(
          "Status",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18
          ),
        )
    ),
    // DataColumn(
    //     label: Text(
    //       "Action",
    //       style: TextStyle(
    //           fontWeight: FontWeight.bold,
    //           fontSize: 18
    //       ),
    //     )
    // )
  ];

  @override
  void initState() {
    searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
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
        title: Text("Appointments"),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      drawer: CustomDrawer(),
      body: ScopedModel<DoctorAppointmentModel>(
        model: DoctorAppointmentModel(),
        child: Builder(
            builder: (context) {
              DoctorAppointmentModel.of(context).getAppointmentList();
              DoctorAppointmentModel.of(context).getDepartmentsList();
              DoctorAppointmentModel.of(context).getDoctorList();
              DoctorAppointmentModel.of(context).getDoctorList();
              DoctorAppointmentModel.of(context).getPatientsList();
              return ScopedModelDescendant<DoctorAppointmentModel>(
                builder: (context,_,model) {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: screenWidth / 10,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
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
                                  filled: true,
                                  fillColor: Colors.white,
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50),
                                      borderSide: BorderSide.none
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50),
                                      borderSide: BorderSide(color: primaryColor, width: 2)
                                  ),
                                  prefixIcon: Icon(Icons.search_outlined),
                                  hintText: "Search"
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: screenWidth / 10,),
                        customDataTable(
                          tableName: "Appointments",
                          context: context,
                          dataTableColumns: appointmentColumns,
                          dataTableRows: List.generate(
                            model.appointmentList.length,
                            (index) {
                              final ids = model.appointmentList[index].id.toString();
                              final departmentNames = model.departmentList.elementAt(model.appointmentList[index].departmentId).name;
                              final doctorNames = model.doctorList.elementAt(model.appointmentList[index].docId).name;
                              final serviceNames = model.serviceList.elementAt(model.appointmentList[index].serviceId).name;
                              final patientNames = model.appointmentList[index].name.toString();
                              final timings = model.appointmentList[index].time.toString();
                              final messages = model.appointmentList[index].messages.toString();
                              final status = model.appointmentList[index].status.toString();
                              print("ids $ids");
                              return DataRow(
                                cells: [
                                  DataCell(Text(ids)),
                                  DataCell(Text(departmentNames)),
                                  DataCell(Text(doctorNames)),
                                  DataCell(Text(serviceNames)),
                                  DataCell(Text(patientNames)),
                                  DataCell(Text(timings)),
                                  DataCell(Text(messages)),
                                  DataCell(Text(status)),
                                ]
                              );
                            }
                          ),
                          hasShowAll: false
                        ),
                        SizedBox(height: screenWidth / 10,),
                      ],
                    ),
                  );
                }
              );
            }
        )
      )
    );
  }
}
