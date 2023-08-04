import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:singleclinic/modals/product_model.dart';
import 'package:singleclinic/utils/colors.dart';
import 'package:singleclinic/utils/helper.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;
  const ProductDetailsScreen({Key key,this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
        title: Text(
          product.name,
          style: GoogleFonts.poppins(fontSize: 20, color: Colors.black),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(primary: primaryColor,padding: EdgeInsets.all(20)),
            child: Text("Continue Shopping",
                style: GoogleFonts.poppins().copyWith(color: Colors.white))),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            CarouselSlider(
              options: CarouselOptions(
                  height: 300.0,
                  initialPage: 0,
                  enableInfiniteScroll: false,
                  viewportFraction: 0.75),
              items: [0, 1, 2]
                  .map((e) => Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.network(
                            getImageUrl(product.photo),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ))
                  .toList(),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              product.name,
              style: GoogleFonts.poppins()
                  .copyWith(color: Colors.black, fontSize: 19),
            ),
            Text(
              product.type,
              style: GoogleFonts.poppins()
                  .copyWith(color: Colors.black, fontSize: 17),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 80,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: Colors.black.withOpacity(0.2))),
                  child: DropdownButton(
                    onChanged: (value) {},
                    items: [
                      DropdownMenuItem(
                        child: Text(
                          "2",
                          style: GoogleFonts.poppins()
                              .copyWith(color: Colors.black, fontSize: 17),
                        ),
                      ),
                    ],
                    underline: SizedBox(),
                    isExpanded: true,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text("Add"),
                  style: ElevatedButton.styleFrom(
                      primary: primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ],
            ),
            Divider(),
            Text("Description"),
            SizedBox(
              height: 8,
            ),
            SizedBox(
              height: 150,
              child: Text(
                product.description,
                overflow: TextOverflow.fade,
              )
            )
          ],
        ),
      ),
    );
  }
}
