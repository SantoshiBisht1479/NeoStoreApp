import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:neostore/bloc/productDetailBloc.dart/productDetailBloc.dart';
import 'package:neostore/bloc/productDetailBloc.dart/productDetail_events.dart';
import 'package:neostore/bloc/productDetailBloc.dart/productDetail_states.dart';
import 'package:neostore/widgets/popUpRating.dart';
import 'package:neostore/shared_preference/shared_preference.dart';
import 'package:neostore/widgets/quantityPopUpDialog.dart';
import 'package:sizer/sizer.dart';

class ProductDetailScreen extends StatefulWidget {
  var product_id;
  //ProductDetailModel productDetailModel;
  var category;
  ProductDetailScreen({@required this.product_id, @required this.category});
  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  Future<dynamic> accessToken;
  var currentaccessToken;
  //ProductDetailModel _productDetailModel;
  String currentProductId;
  var currentCategory;
  var currentIndex = 0;
  @override
  void initState() {
    super.initState();
    accessToken = SharedPrefernceData.getToken();
    accessToken.then((value) {
      currentaccessToken = value;
    });
    print(currentaccessToken);
  }

  @override
  Widget build(BuildContext context) {
    //_productDetailModel = widget.product_id;
    currentProductId = widget.product_id;

    currentCategory = widget.category;

    setState(() {
      BlocProvider.of<ProductDetailBloc>(context)
          .add(FetchProductDetails(productId: currentProductId));
    });

    return BlocBuilder<ProductDetailBloc, ProductDetailStates>(
        builder: (context, state) {
      if (state is InitialProductDetailstates) {
        return Scaffold(
            body: Center(
                child: CircularProgressIndicator(
          backgroundColor: Theme.of(context).primaryColor,
        )));
      }
      if (state is LoadingProductDetailsStates) {
        return Scaffold(
            body: Center(
                child: CircularProgressIndicator(
          backgroundColor: Theme.of(context).primaryColor,
        )));
      }

      if (state is LoadedProductDetailStates) {
        var data = state.productDetailModel.data;
        return Scaffold(
            appBar: AppBar(
              title: Text(data.name),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(1.0.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 1.0.h),
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data.name,
                                  style: TextStyle(
                                      fontSize: 18.0.sp,
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  'Category - $currentCategory',
                                  style: TextStyle(
                                    fontSize: 14.0.sp,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(data.producer),
                                    RatingBar(
                                      //onRatingUpdate: (value) => null,
                                      itemSize: 16,
                                      initialRating: data.rating.toDouble(),
                                      direction: Axis.horizontal,
                                      itemCount: 5,
                                      ratingWidget: RatingWidget(
                                          half: null,
                                          empty: Image.asset(
                                            'assets/images/star_unchek.png',
                                          ),
                                          full: Image.asset(
                                              'assets/images/star_check.png')),
                                      itemPadding:
                                          EdgeInsets.symmetric(horizontal: 2.0),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 1.0.h),
                          child: Container(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Rs. ${data.cost}',
                                      style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0.sp),
                                    ),
                                    InkWell(
                                      child: Image.asset(
                                          'assets/images/share.png'),
                                    )
                                  ],
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 2.5.h),
                                  child: Container(
                                    height: 250,
                                    width: 500,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(data
                                                .productImages[currentIndex]
                                                .image),
                                            fit: BoxFit.cover)),
                                  ),
                                ),
                                Container(
                                  height: 150,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: data.productImages.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 1.0.h,
                                              vertical: 1.0.h),
                                          child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                currentIndex = index;
                                              });
                                            },
                                            child: Container(
                                              width: 170,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: 2,
                                                      color: currentIndex ==
                                                              index
                                                          ? Theme.of(context)
                                                              .primaryColor
                                                          : Colors.black),
                                                  image: DecorationImage(
                                                      image: NetworkImage(data
                                                          .productImages[index]
                                                          .image),
                                                      fit: BoxFit.cover)),
                                            ),
                                          ),
                                        );
                                      }),
                                )
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 1.0.h, vertical: 1.0.h),
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'DESCRIPTION',
                                  style: TextStyle(
                                      fontSize: 23,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  data.description,
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 1.0.w, vertical: 2.0.h),
                          child: Container(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                flex: 3,
                                child: InkWell(
                                    onTap: () {
                                      quantityPopUpDialog(
                                          context, data, currentaccessToken);
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 50,
                                      width: 45.0.w,
                                      child: Text(
                                        'BUY NOW',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 25),
                                      ),
                                      decoration: BoxDecoration(
                                          color: Theme.of(context).primaryColor,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                    )),
                              ),
                              Flexible(
                                flex: 3,
                                child: InkWell(
                                    onTap: () {
                                      //ShowPopUpRating(productDetailData: _productDetailModel.data,);

                                      popUpDialog(context, data);

                                      // popUpDialog(
                                      //     context, _productDetailModel.data);
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 50,
                                      width: 45.0.w,
                                      child: Text(
                                        'RATE',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 25),
                                      ),
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade300,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                    )),
                              )
                            ],
                          )),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ));
      }
      if (state is FailureProductDetailStates) {
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }
    });
  }
}
