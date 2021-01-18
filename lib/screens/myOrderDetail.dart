import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neostore/bloc/myOrdersBloc.dart/myOrderStates.dart';
import 'package:neostore/bloc/myOrdersBloc.dart/myOrdersBloc.dart';
import 'package:neostore/bloc/myOrdersBloc.dart/myOrders_events.dart';
import 'package:sizer/sizer.dart';

class MyOrderDetailScreen extends StatefulWidget {
  int orderId;
  String accessToken;
  MyOrderDetailScreen({@required this.accessToken, @required this.orderId});
  @override
  _MyOrderDetailScreenState createState() => _MyOrderDetailScreenState();
}

class _MyOrderDetailScreenState extends State<MyOrderDetailScreen> {
  @override
  Widget build(BuildContext context) {
    setState(() {
      BlocProvider.of<MyOrdersBloc>(context).add(GetOrderDetailEvent(
          accessToken: widget.accessToken, orderId: widget.orderId));
    });
    return Scaffold(
      appBar: AppBar(title: Text('Order ID : ${widget.orderId}'), actions: [
        InkWell(
          onTap: () {
            print('searching...');
          },
          child: Image.asset('assets/images/search_icon.png'),
        )
      ]),
      body: BlocBuilder<MyOrdersBloc, MyOrderState>(builder: (context, state) {
        if (state is InitialOrderState) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Theme.of(context).primaryColor,
            ),
          );
        }
        if (state is LoadingOrderState) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Theme.of(context).primaryColor,
            ),
          );
        }
        if (state is LoadedOrderState) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Theme.of(context).primaryColor,
            ),
          );
        }

        if (state is SuccessOrderDetailState) {
          return SingleChildScrollView(
            child: Column(children: [
              //Text('hello'),
              ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: state.myOrderDetailModel.data.orderDetails.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var data =
                        state.myOrderDetailModel.data.orderDetails[index];
                    return Container(
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
                                      image:
                                          // AssetImage(
                                          //     'assets/images/sofaicon.png'),
                                          NetworkImage(data.prodImage),
                                      fit: BoxFit.contain)),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data.prodName,
                                  style: TextStyle(
                                      fontSize: 16.0.sp,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  '(${data.prodCatName})',
                                  style: TextStyle(
                                    fontSize: 13.0.sp,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(vertical: 1.0.h),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        child: Text(
                                          'QTY : ${data.quantity}',
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w300),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10.0.w),
                                          child: Container(
                                              alignment: Alignment.centerRight,
                                              child: Text(
                                                'Rs. ${data.total}.00',
                                                style: TextStyle(fontSize: 14),
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
                    );
                  }),
              Padding(
                padding: EdgeInsets.all(1.0.h),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 3.0.w,
                  ),
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
                        'Rs. ${state.myOrderDetailModel.data.cost}.00',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
            ]),
          );
        }
        if (state is FailureOrderState) {
          return Container(
            child: Text(state.errorMessage),
          );
        }
      }),
    );
  }
}
