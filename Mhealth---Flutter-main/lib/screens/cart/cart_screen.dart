import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:singleclinic/screens/cart/widgets/cart_item_vertical_widget.dart';
import 'package:singleclinic/utils/colors.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff6f6f6),
      appBar: AppBar(
        title: Text(
          "Cart",
          style: GoogleFonts.poppins().copyWith(color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        leading: Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
        ),
        
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(10),
        height: 60,
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(8)
        ),
        child: Center(child: Text("Proceed to Buy",style: GoogleFonts.poppins().copyWith(color: Colors.white,fontSize: 20),)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              itemBuilder: (context, index) => CartItemVertical(),
              itemCount: 2,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
            ),

            //Additional Note
            Container(
              margin: EdgeInsets.all(8),
              padding: EdgeInsets.all(8),
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(8)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Additional Text"),
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.multiline,
                      maxLines: null,                      decoration: InputDecoration(
                        hintText: "Enter any additional text regarding your order",
                        border: InputBorder.none,
                        hintMaxLines: 4,
                        hintStyle: GoogleFonts.poppins().copyWith(color: Colors.grey.withOpacity(0.8))
                      ),
                    ),
                  )
                ],
              ),
            ),
            
            
            // Container(
            //   width: double.infinity,
            //   padding: EdgeInsets.all(12),
            //   margin: EdgeInsets.all(8),
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(16),
            //     color: Colors.grey.withOpacity(0.2)
            //
            //   ),
            //   child: Row(
            //     children: [
            //       Icon(Icons.local_offer_outlined,size:35),
            //       SizedBox(width: 8,),
            //       Text("Apply Coupon",style: GoogleFonts.poppins().copyWith(fontWeight: FontWeight.w500,fontSize: 19),),
            //       Spacer(),
            //       Icon(CupertinoIcons.arrow_right_circle,size:35,color: primaryColor,),
            //
            //
            //     ],
            //   ),
            // ),
            // Container(
            //   width: double.infinity,
            //   padding: EdgeInsets.all(12),
            //   margin: EdgeInsets.all(8),
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(16),
            //     color: Colors.grey.withOpacity(0.2)
            //
            //   ),
            //   child: Row(
            //     children: [
            //       Icon(Icons.account_balance_wallet_outlined,size:35),
            //       SizedBox(width: 8,),
            //       Text("Wallet",style: GoogleFonts.poppins().copyWith(fontWeight: FontWeight.w500,fontSize: 19),),
            //       Spacer(),
            //       Text("\$100",style: GoogleFonts.poppins().copyWith(fontWeight: FontWeight.w500,fontSize: 16),),
            //
            //       Checkbox(value: false, onChanged: (value){})
            //
            //
            //     ],
            //   ),
            // ),
            SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Cart Value",style: GoogleFonts.poppins().copyWith(fontWeight: FontWeight.w500,fontSize: 16),),
                  Text("\$400",style: GoogleFonts.poppins().copyWith(fontWeight: FontWeight.w700,fontSize: 16),),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.2)

              ),
              child: Row(
                children: [
                  Icon(Icons.location_on_outlined,color: primaryColor,),
                  SizedBox(width: 8,),
                  Expanded(child: Text("Birtanagar Nepal 3024, 34 N.H Highway",style: GoogleFonts.poppins().copyWith(fontWeight: FontWeight.w500,fontSize: 16),)),


                  Text("Change",style: GoogleFonts.poppins().copyWith(fontWeight: FontWeight.w500,fontSize: 16,color: Colors.blue),),



                ],
              ),
            ),


            
          ],
        ),
      ),
    );
  }
}
