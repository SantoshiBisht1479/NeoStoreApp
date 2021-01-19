import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:neostore/bloc/productDetailBloc.dart/productDetailBloc.dart';
import 'package:neostore/bloc/productDetailBloc.dart/productDetail_events.dart';
import 'package:neostore/model/product_detail_model.dart' as product;
import 'package:sizer/sizer.dart';

popUpDialog(BuildContext context, product.Data productDetaildata) {
  double currentRating;
  return showDialog(
    context: (context),
    builder: (context) {
      return AlertDialog(
        //contentPadding: EdgeInsets.all(1.0.h),
        elevation: 10,
        title: Center(
          child: Text(
            '${productDetaildata.name}',
            style: TextStyle(fontSize: 26),
          ),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.all(2.0.h),
                child: Container(
                  height: 30.0.h,
                  //width: 40.0.w,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                            '${productDetaildata.productImages[0].image}',
                          ),
                          fit: BoxFit.fill)),
                ),
              ),
              Container(
                child: RatingBar(
                  onRatingUpdate: (value) {
                    print(value);
                    currentRating = value;
                  },
                  initialRating: productDetaildata.rating.toDouble(),
                  itemPadding: EdgeInsets.all(4.0),
                  itemCount: 5,
                  ratingWidget: RatingWidget(
                      empty: Image.asset('assets/images/star_unchek.png'),
                      full: Image.asset('assets/images/star_check.png'),
                      half: null),
                ),
              )
            ],
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 3.0.h),
            child: InkWell(
              onTap: () {
                print('tapped');

                BlocProvider.of<ProductDetailBloc>(context).add(
                    SubmitRatingEvent(
                        productId: '${productDetaildata.id}',
                        ratings: currentRating.toInt()));

                Navigator.pop(context);
              },
              child: Container(
                height: 6.0.h,
                width: 40.0.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(7.0)),
                child: Text(
                  'RATE NOW',
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
              ),
            ),
          )
        ],
      );
    },
  );
}
