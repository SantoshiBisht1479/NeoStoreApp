import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:neostore/bloc/CartBloc/CartBloc.dart';
import 'package:neostore/bloc/CartBloc/cartBloc_events.dart';
import 'package:neostore/bloc/CartBloc/cartBloc_states.dart';
import 'package:neostore/screens/address_List.dart';
import 'package:sizer/sizer.dart';

class MyCartScreen extends StatefulWidget {
  String accessToken;
  MyCartScreen({@required this.accessToken});
  @override
  _MyCartScreenState createState() => _MyCartScreenState();
}

class _MyCartScreenState extends State<MyCartScreen> {
  List<int> menuItems = [1, 2, 3, 4, 5, 6, 7, 8];
  // int dropdownvalue = 1;
  var totalValue;
  var dropdownValue;

  @override
  Widget build(BuildContext context) {
    setState(() {
      BlocProvider.of<CartBlocList>(context)
          .add(ListCartListEvent(access_token: widget.accessToken));
    });
    return Scaffold(
      appBar: AppBar(
        title: Text('My Cart'),
      ),
      body: ListView(children: [
        BlocBuilder<CartBlocList, CartBlocStates>(builder: (context, states) {
          if (states is InitialCartBlocState) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Theme.of(context).primaryColor,
              ),
            );
          }

          if (states is LoadingCartBlocState) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Theme.of(context).primaryColor,
              ),
            );
          }

          if (states is EmptyCartBlocState) {
            return Center(
              child: Container(
                child: Text(
                  states.errorModel.message,
                  style: TextStyle(fontStyle: FontStyle.italic, fontSize: 20),
                ),
              ),
            );
          }

          if (states is LoadedCartBlocState) {
            if (states.addToCartListModel.data.length > 0) {
              totalValue = states.addToCartListModel.total;

              return SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: states.addToCartListModel.data.length,
                        itemBuilder: (context, index) {
                          dropdownValue =
                              states.addToCartListModel.data[index].quantity;
                          var data = states.addToCartListModel.data;
                          return Slidable(
                            actionPane: SlidableDrawerActionPane(),
                            actionExtentRatio: 0.25,
                            child: Container(
                              color: Colors.white,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(2.0.h),
                                    child: Container(
                                      height: 13.0.h,
                                      width: 13.0.h,
                                      decoration: BoxDecoration(
                                          //color: Colors.amber,
                                          image: DecorationImage(
                                              image: NetworkImage(data[index]
                                                  .product
                                                  .productImages),
                                              fit: BoxFit.contain)),
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${data[index].product.name}',
                                          style: TextStyle(
                                              fontSize: 16.0.sp,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          '(${data[index].product.productCategory})',
                                          style: TextStyle(
                                            fontSize: 13.0.sp,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 1.0.h),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              DropdownButton(
                                                  icon: Image.asset(
                                                      'assets/images/select_button.png'),
                                                  value: dropdownValue,
                                                  items: <int>[
                                                    1,
                                                    2,
                                                    3,
                                                    4,
                                                    5,
                                                    6,
                                                    7,
                                                    8
                                                  ].map<DropdownMenuItem>(
                                                      (value) {
                                                    return DropdownMenuItem(
                                                        value: value,
                                                        child: Text('$value'));
                                                  }).toList(),
                                                  onChanged: (newvalue) {
                                                    setState(() {
                                                      BlocProvider.of<
                                                                  CartBlocList>(
                                                              context)
                                                          .add(EditCartItems(
                                                              accessToken: widget
                                                                  .accessToken,
                                                              productId: states
                                                                  .addToCartListModel
                                                                  .data[index]
                                                                  .productId,
                                                              quantity:
                                                                  newvalue));
                                                    });
                                                  }),
                                              Expanded(
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10.0.w),
                                                  child: Container(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: Text(
                                                        'Rs. ${data[index].product.subTotal}.00',
                                                        style: TextStyle(
                                                            fontSize: 14),
                                                      )),
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
                            secondaryActions: <Widget>[
                              IconSlideAction(
                                iconWidget: Container(
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/delete.png'))),
                                ),
                                onTap: () {
                                  BlocProvider.of<CartBlocList>(context).add(
                                      DeleteCartItem(
                                          accessToken: widget.accessToken,
                                          product_id: states.addToCartListModel
                                              .data[index].productId));
                                },
                              ),
                            ],
                          );
                        }),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 2.0.w),
                      height: 5.0.h,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            'TOTAL',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Rs. $totalValue .00',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddressListPage()))
                            .then((value) {
                          setState(() {});
                        });
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 4.0.w, vertical: 2.0.h),
                        child: Container(
                          alignment: Alignment.center,
                          //padding: EdgeInsets.only(top: 2.0.h),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Theme.of(context).primaryColor),
                          width: double.infinity,
                          height: 60,
                          child: Text(
                            'ORDER NOW',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 22.0.sp,
                                fontFamily: 'GothamMedium'),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            }
          } else {
            return Center(
              child: Text('Cart is empty'),
            );
          }
          if (states is FailureCartBlocState) {
            return Center(
              child: Text(states.errorMessage),
            );
          }
        }),
      ]),
    );
  }
}
