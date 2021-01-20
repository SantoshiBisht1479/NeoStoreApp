import 'package:flutter/material.dart';
import 'package:neostore/screens/product_list.dart';
import 'package:sizer/sizer.dart';

class GridModel {
  String image;
  String categoryId;
  String categoryName;

  GridModel({this.image, this.categoryId, this.categoryName});
}

List<GridModel> productGridImage = [
  GridModel(
      image: 'assets/images/tableicon.png',
      categoryName: 'Tables',
      categoryId: '1'),
  GridModel(
      image: 'assets/images/sofaicon.png',
      categoryName: 'Sofas',
      categoryId: '3'),
  GridModel(
      image: 'assets/images/chairsicon.png',
      categoryName: 'Chairs',
      categoryId: '2'),
  GridModel(
      image: 'assets/images/cupboardicon.png',
      categoryName: 'Cupboards',
      categoryId: '4')
];
var currentIndex = 0;

Widget productGrid(BuildContext context) {
  return Container(
    padding: EdgeInsets.all(1.0.h),
    child: GridView.builder(
        shrinkWrap: true,
        itemCount: productGridImage.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 2.5.h, mainAxisSpacing: 2.5.h),
        itemBuilder: (BuildContext context, index) {
          return InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProductList(
                              title: productGridImage[index].categoryName,
                              productCategoryId:
                                  productGridImage[index].categoryId,
                            )));
              },
              child: Image.asset(productGridImage[index].image));
        }),
  );
}
