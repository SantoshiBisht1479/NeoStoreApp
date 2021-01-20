import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neostore/bloc/myOrdersBloc.dart/myOrderStates.dart';
import 'package:neostore/bloc/myOrdersBloc.dart/myOrdersBloc.dart';
import 'package:neostore/bloc/myOrdersBloc.dart/myOrders_events.dart';
import 'package:neostore/screens/myOrderDetail.dart';

class MyOrdersScreen extends StatefulWidget {
  String accessToken;
  MyOrdersScreen({@required this.accessToken});
  @override
  _MyOrdersScreenState createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  @override
  Widget build(BuildContext context) {
    setState(() {
      BlocProvider.of<MyOrdersBloc>(context)
          .add(GetMyOrdersEvent(accessToken: widget.accessToken));
    });
    return Scaffold(
      appBar: AppBar(title: Text('My Orders'), actions: [
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

        if (state is SuccessOrderDetailState) {
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
        if (state is EmptyOrderState) {
          return Center(
            child: Container(
              child: Text(
                state.emptyMessage,
                style: TextStyle(
                    
                    fontSize: 20,
                    fontStyle: FontStyle.italic),
              ),
            ),
          );
        }

        if (state is LoadedOrderState) {
          return Container(
            child: ListView.builder(
                itemCount: state.myOrderModel.data.length,
                itemBuilder: (context, index) {
                  var data = state.myOrderModel.data[index];
                  return Card(
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyOrderDetailScreen(
                                    accessToken: widget.accessToken,
                                    orderId: data.id))).then((value) {
                          setState(() {});
                        });
                      },
                      title: Text(
                        'Order ID : ${data.id}',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                      subtitle: Text('Ordered Date : ${data.created}'),
                      trailing: Text('Rs. ${data.cost}',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w300)),
                    ),
                  );
                }),
          );
        }

        if (state is FailureOrderState) {
          return Center(
            child: Text(state.errorMessage),
          );
        }
      }),
    );
  }
}
