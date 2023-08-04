import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:singleclinic/utils/colors.dart';

class CartItemVertical extends StatelessWidget {
  const CartItemVertical({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String hospitalImage =
"https://m.media-amazon.com/images/I/71z-zdxxXaL._SY450_PIbundle-2,TopRight,0,0_AA450SH20_.jpg";
    return  Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 1,color: Colors.grey.withOpacity(0.5))
          )
           ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 6.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      hospitalImage,
                      width: 50,
                      fit: BoxFit.cover,
                      height: 50,
                    )),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Himalaya Tablet",
                      style: TextStyle(
                          fontSize: 19),
                    ),
                    SizedBox(height: 8),
                    Text("\$100",style: GoogleFonts.poppins().copyWith(fontWeight: FontWeight.bold),),
                    SizedBox(height: 8,),

                    Text("20 Tablets in Strip"),

                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,

                children: [
                  IconButton(onPressed: (){}, icon: Icon(CupertinoIcons.delete,color: primaryColor,)),
                  Row(
                    children: [
                      IconButton(onPressed: (){}, icon: Icon(Icons.indeterminate_check_box_rounded,color: primaryColor,)),

                      Text("1",style: GoogleFonts.poppins().copyWith(color: primaryColor,fontWeight: FontWeight.bold),),
                      IconButton(onPressed: (){}, icon: Icon(Icons.add_box_sharp,color: primaryColor,))
                    ],
                  ),

                ],
              )
            ],
          ),
        ));
  }
}
