import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:singleclinic/modals/DepartmentDetails.dart';
import 'package:singleclinic/modals/appointment_model.dart';
import 'package:singleclinic/modals/appointment_status_model.dart';
import 'package:singleclinic/modals/department_model.dart';
import 'package:singleclinic/modals/patient_model.dart';
import 'package:singleclinic/services/api_service.dart';

import '../modals/Doctor_model.dart';

class AppointmentModel extends Model{


 static AppointmentModel of(BuildContext context)=>ScopedModel.of<AppointmentModel>(context);
  List<Patient> patientsList=[];
  List<Appointment> appointmentList=[];
  List<Department> departmentList = [];
  List<Doctor> doctorList = [];
  List<Service> serviceList = [];
  Patient selectedPatient;
  String selectedDate;
  String selectedTime;
  ApiService service=ApiService.instance;
  AppointmentModel(){
    getPatientsList();
    getDoctorList();
    getDepartmentsList();
  }

  getDepartmentsList() async {
    departmentList = await service.getDepartments();
    notifyListeners();
  }


  getPatientsList()async{
    patientsList=await service.getPatients();
    notifyListeners();

  }
  getAppointmentList()async{
    appointmentList=await service.getAppointment();
    notifyListeners();
  }
 getDoctorList()async{
   doctorList=await service.getDoctors();
   notifyListeners();
 }
 // getServiceList()async{
 //   doctorList=await service.getDoctors();
 //   notifyListeners();
 // }

 Future<ApointmentStatus> bookAppointment({int doctorId})async{
    var data={
      "patient_id":selectedPatient.id.toString(),
      "doctor_id":doctorId.toString(),
      "date":selectedDate.toString(),
      "time":selectedTime.toString(),

    };
   return await service.bookAppointment(data: data);


  }


}