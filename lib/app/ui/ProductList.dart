import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kalkulator_plts/app/widget/recource.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../generated/json/product_list_entity.g.dart';
import '../model/product_list_entity.dart';

class ProductListArgument {
  final double? dailyLoadPlan;
  final String? currentType;
  ProductListArgument(
      {this.dailyLoadPlan, this.currentType});
}

class ProductList extends StatefulWidget {
  final ProductListArgument? args;
  const ProductList({Key? key, this.args}) : super(key: key);

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {

  List<ProductListProductList> productList = [];

  @override
  void initState() {
    readJson();
    super.initState();
  }

  Future<void> readJson() async {
    var response = await rootBundle.loadStructuredData('assets/product_list.json', (String s) async {
      return json.decode(s);
    });
    ProductListEntity data = $ProductListEntityFromJson(response);
    productList.addAll(data.productList ?? []);
    setState(() {

    });
  }

  _launchURL(String productUrl) async {
  String url = productUrl;
  await launch(url);
}

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.whiteFefefe,
        body: ListView(
          children: [
            const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                  "Rekomendasi Produk",
                  style: GoogleFonts.montserrat(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: AppColor.defaultBlue),
                ),
            ),
            const SizedBox(height: 20,),
            ListView.builder(
              shrinkWrap: true,
              primary: false,
              itemCount: productList.length,
                itemBuilder: (context, index) =>
                widget.args?.currentType == 'DC' && productList[index].type == 'AC'
                    || widget.args?.currentType == 'AC' && productList[index].type == 'DC'?
                    const SizedBox() :
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _buildCartContent(productList[index]),
              )
            )
          ],
        ),
      ),
    );
  }
  
  _buildCartContent(ProductListProductList data) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        _launchURL(data.productUrl ?? '');
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: AppColor.grayC4C4C4),
          borderRadius: BorderRadius.circular(20)
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: size.width * 0.3,
              height: size.width * 0.2,
              decoration: BoxDecoration(
                color: AppColor.grayC4C4C4
              ),
              child: Visibility(
                visible: data.image != '',
                  child: Image.network(data.image ?? '',
                    fit: BoxFit.fill,
                  )
              ),
            ),
            const SizedBox(width: 10,),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: size.width * 0.45,
                  child: Text(
                      data.productName ?? '',
                      style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black.withOpacity(0.7)),
                    ),
                ),
                const SizedBox(height: 10,),
                Text(
                    data.type ?? '',
                    style: GoogleFonts.montserrat(
                        fontSize: 12,
                        color: Colors.black.withOpacity(0.7)),
                  ),
                Text(
                    data.merk ?? '',
                    style: GoogleFonts.montserrat(
                        fontSize: 12,
                        color: Colors.black.withOpacity(0.7)),
                  ),
                Text(
                    data.price ?? '',
                    style: GoogleFonts.montserrat(
                        fontSize: 13,
                        color: Colors.black.withOpacity(0.7)),
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
