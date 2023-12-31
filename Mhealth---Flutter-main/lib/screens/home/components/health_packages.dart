import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:singleclinic/common/widgets/heading_tile.dart';
import 'package:singleclinic/common/widgets/horizontal_shimmer_list.dart';
import 'package:singleclinic/main.dart';
import 'package:singleclinic/modals/HealthPackage.dart';
import 'package:singleclinic/modals/hospital_model.dart';
import 'package:singleclinic/scoped_models/product_models.dart';
import 'package:singleclinic/screens/product/product_details_screen.dart';
import 'package:singleclinic/screens/shop/shop_screen.dart';
import 'package:singleclinic/utils/colors.dart';
import 'package:singleclinic/utils/extensions/padding.dart';
import 'package:singleclinic/utils/helper.dart';

class HealthPackages extends StatefulWidget {
  const HealthPackages({Key key}) : super(key: key);

  @override
  State<HealthPackages> createState() => _HealthPackagesState();
}

class _HealthPackagesState extends State<HealthPackages> {
  HealthPackage healthPackage;

  @override
  void initState() {
    fetchPlans();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: SizedBox(
        width: 400,
        height: 200,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: healthPackage.data.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(0,0,15,0),
              child: Container(
                height: 200,
                width: 145,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12)
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      healthPackage.data[index].name,
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        ),
      ),
    );
  }
  fetchPlans() async {
    final response = await get(Uri.parse("$SERVER_ADDRESS/api/gethealthpackage"));
    final jsonResponse = jsonDecode(response.body);
    if (response.statusCode == 200 && jsonResponse['status'] == 1) {
      setState(() {
        healthPackage = HealthPackage.fromJson(jsonResponse);
      });
    }
  }
}
