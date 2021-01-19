import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neostore/bloc/productDetailBloc.dart/productDetailBloc.dart';
import 'package:neostore/bloc/productDetailBloc.dart/productDetail_events.dart';
import 'package:neostore/model/product_detail_model.dart' as product;
import 'package:sizer/sizer.dart';

quantityPopUpDialog(
    BuildContext context, product.Data productDetaildata, var accessToken) {
  TextEditingController quantityController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  return showDialog(
    context: (context),
    builder: (context) {
      return SingleChildScrollView(
        child: AlertDialog(
          //contentPadding: EdgeInsets.all(1.0.h),
          elevation: 10,
          title: Center(
            child: Text(
              '${productDetaildata.name}',
              style: TextStyle(fontSize: 26),
            ),
          ),
          content: Column(
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
                  child: Column(
                children: [
                  Text('Enter Qty', style: TextStyle(fontSize: 22)),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 3.0.w, vertical: 1.0.h),
                    child: Container(
                      child: Form(
                        key: _formKey,
                        child: TextFormField(
                            controller: quantityController,
                            cursorColor: Theme.of(context).primaryColor,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Quantity is required';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 2)),
                            )),
                      ),
                    ),
                  )
                ],
              ))
            ],
          ),
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 3.0.h),
              child: InkWell(
                onTap: () {
                  print('tapped');
                  if (_formKey.currentState.validate()) {
                    BlocProvider.of<ProductDetailBloc>(context).add(
                        AddQuantityEvent(
                            accessToken: accessToken,
                            productId: productDetaildata.id,
                            quantity: int.parse(quantityController.text)));
                    Navigator.pop(context);
                  }
                },
                child: Container(
                  height: 6.0.h,
                  width: 40.0.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(7.0)),
                  child: Text(
                    'SUBMIT',
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    },
  );
}
