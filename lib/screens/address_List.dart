import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neostore/bloc/AddressBloc/addressBloc.dart';
import 'package:neostore/bloc/AddressBloc/addressBloc_events.dart';
import 'package:neostore/bloc/AddressBloc/addressBloc_states.dart';
import 'package:neostore/screens/addressDetail.dart';
import 'package:neostore/shared_preference/shared_preference.dart';
import 'package:sizer/sizer.dart';

enum AddressSelected { selected, notSelected }

class AddressListPage extends StatefulWidget {
  @override
  _AddressListPageState createState() => _AddressListPageState();
}

class _AddressListPageState extends State<AddressListPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Future<dynamic> accessToken = SharedPrefernceData.getToken();
  Future<dynamic> userName = SharedPrefernceData.getuser();
  var currentUser;
  var currentAccessToken;
  String currentAddress;
  int radioValue = 8;
  //AddressSelected radioValue = AddressSelected.selected;
  @override
  void initState() {
    super.initState();
    userName.then((value) {
      setState(() {
        currentUser = value;
      });
    });
    accessToken.then((value) {
      setState(() {
        currentAccessToken = value;
      });
    });

    // setState(() {
    //   BlocProvider.of<AddressBloc>(context).add(AddNewAddressEvent());
    // });
    //BlocProvider.of<AddressBloc>(context).add(AddNewAddressEvent());
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      BlocProvider.of<AddressBloc>(context).add(AddNewAddressEvent());
    });

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Address List'),
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddressDetail()))
                  .then((value) {
                setState(() {});
              });
            },
            child: Icon(
              Icons.add,
              size: 40,
            ),
          )
        ],
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 2.0.h, vertical: 3.0.h),
                child: Text(
                  'Shipping Address',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              BlocBuilder<AddressBloc, AddressBlocState>(
                  builder: (context, state) {
                if (state is InitialAddressBlocState) {
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                  );
                }

                if (state is LoadingAddressBlocState) {
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                  );
                }
                if (state is SuccessOrderPlaceState) {
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                  );
                }
                if (state is SuccessAddressBlocState) {
                  if (state.addressModel.isEmpty) {
                    return Container(
                      child: Text('No shipping Address Added'),
                    );
                  } else {
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.addressModel.length,
                        itemBuilder: (context, index) {
                          //print(state.addressModel[index].id);
                          //radioValue = state.addressModel[index].id;
                          return Card(
                            child: ListTile(
                              leading: Radio(
                                activeColor: Theme.of(context).primaryColor,
                                groupValue: radioValue,
                                value: state.addressModel[index].id,
                                //toggleable: true,
                                onChanged: (int value) {
                                  setState(() {
                                    // print(radioValue);
                                    currentAddress =
                                        state.addressModel[index].address;
                                    radioValue = value;
                                    // if (radioValue == value) {
                                    //   print(true);
                                    // }
                                  });
                                },
                              ),
                              title: Text(
                                currentUser,
                                style: TextStyle(fontSize: 24),
                              ),
                              subtitle: Text(
                                '${state.addressModel[index].address}',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 14),
                              ),
                              trailing: InkWell(
                                onTap: () {
                                  setState(() {
                                    BlocProvider.of<AddressBloc>(context).add(
                                        DeleteAddressEvent(
                                            id: state.addressModel[index].id));
                                  });
                                },
                                child: Icon(Icons.clear),
                              ),
                            ),
                          );
                        });
                  }
                }

                if (state is FailureAddressBlocState) {
                  return Container(
                    child: Text(state.errorMessage),
                  );
                }
              }),
              BlocListener<AddressBloc, AddressBlocState>(
                listener: (context, state) {
                  if (state is SuccessOrderPlaceState) {
                    _scaffoldKey.currentState.showSnackBar(SnackBar(
                        content:
                            Text('${state.forgotPassResponsetModel.userMsg}')));
                  }
                  // if (state is FailureAddressBlocState) {
                  //   return Container(
                  //     child: Text('${state.errorMessage}'),
                  //   );
                  // }
                },
                child: InkWell(
                  onTap: () {
                    setState(() {
                      BlocProvider.of<AddressBloc>(context).add(PlaceOrderEvent(
                          accessToken: currentAccessToken,
                          address: currentAddress));
                    });

                    //Navigator.pop(context);
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
                        'PLACE ORDER ',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22.0.sp,
                            fontFamily: 'GothamMedium'),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
