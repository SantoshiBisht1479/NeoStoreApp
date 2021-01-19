import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:neostore/bloc/productListBloc/productList_events.dart';
import 'package:neostore/bloc/productListBloc/productList_states.dart';
import 'package:neostore/bloc/productListBloc/product_bloc.dart';
import 'package:neostore/screens/product_detail.dart';
import 'package:sizer/sizer.dart';

class ProductList extends StatefulWidget {
  var title;
  var productCategoryId;
  ProductList({@required this.title, @required this.productCategoryId});
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  var currentTitle;
  var currentProductId;
  @override
  Widget build(BuildContext context) {
    currentTitle = widget.title;
    currentProductId = widget.productCategoryId;

    setState(() {
      BlocProvider.of<ProductListBloc>(context)
          .add(ShowProductList(productId: currentProductId));
    });
    return Scaffold(
      appBar: AppBar(
        title: Text(currentTitle),
      ),
      body: Container(
        child: BlocBuilder<ProductListBloc, ProductListStates>(
            builder: (context, state) {
          if (state is InitialProductList) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Theme.of(context).primaryColor,
              ),
            );
          }
          if (state is LoadingProductListState) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Theme.of(context).primaryColor,
              ),
            );
          }

          if (state is LoadedProductListState) {
            var data = state.productCategoryModel.data;

            return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductDetailScreen(
                                    product_id: '${data[index].id}',
                                    category: currentTitle,
                                  ))).then((value) {
                        setState(() {});
                      });
                    },
                    child: Card(
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(2.0.h),
                            child: Container(
                              height: 13.0.h,
                              width: 13.0.h,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          data[index].productImages),
                                      fit: BoxFit.contain)),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data[index].name,
                                  style: TextStyle(
                                      fontSize: 16.0.sp,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  data[index].producer,
                                  style: TextStyle(
                                    fontSize: 12.0.sp,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(vertical: 1.0.h),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Rs. ${data[index].cost}',
                                        style: TextStyle(
                                            fontSize: 18.0.sp,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Theme.of(context).primaryColor),
                                      ),
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.centerRight,
                                          child: RatingBar(
                                            //onRatingUpdate: (value) => null,
                                            itemSize: 16,
                                            initialRating:
                                                data[index].rating.toDouble(),
                                            direction: Axis.horizontal,
                                            itemCount: 5,
                                            ratingWidget: RatingWidget(
                                                half: null,
                                                empty: Image.asset(
                                                  'assets/images/star_unchek.png',
                                                ),
                                                full: Image.asset(
                                                    'assets/images/star_check.png')),
                                            itemPadding: EdgeInsets.symmetric(
                                                horizontal: 2.0),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                });
          }
          if (state is FailureProductListState) {
            return Container(
              child: Text(state.loginErrorModel.userMsg),
            );
          }
        }),
      ),
    );
  }
}
