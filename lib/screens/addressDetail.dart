import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neostore/bloc/AddressBloc/addressBloc.dart';
import 'package:neostore/bloc/AddressBloc/addressBloc_events.dart';
import 'package:neostore/bloc/AddressBloc/addressBloc_states.dart';
import 'package:neostore/model/addressModel.dart';
import 'package:neostore/pallet.dart';
import 'package:neostore/shared_preference/shared_preference.dart';
import 'package:sizer/sizer.dart';

class AddressDetail extends StatefulWidget {
  @override
  _AddressDetailState createState() => _AddressDetailState();
}

class _AddressDetailState extends State<AddressDetail> {
  Future<dynamic> accessToken = SharedPrefernceData.getToken();
  TextEditingController addressController = TextEditingController();
  TextEditingController landmarkController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController zipController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var currenAccessToken;
  @override
  void initState() {
    super.initState();
    accessToken.then((value) {
      setState(() {
        currenAccessToken = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Add Address'),
        actions: [
          InkWell(
            onTap: () {
              print('searching...');
            },
            child: Image.asset('assets/images/search_icon.png'),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: BlocListener<AddressBloc, AddressBlocState>(
            listener: (context, state) {
              if (state is SuccessAddressBlocState) {
                _scaffoldKey.currentState.showSnackBar(SnackBar(
                    backgroundColor: Colors.black,
                    content: Text(
                      'Address Added Successfully',
                      style: snackBarsuccesstextStyle,
                    )));
              }
            },
            child: Container(
              child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      addressWidget(),
                      addressTextField(),
                      citywidget(),
                      cityTextWidget(),
                      rowOneWidget(),
                      saveAddressbutton()
                    ],
                  )),
            )),
      ),
    );
  }

  addressWidget() {
    return Padding(
      padding: EdgeInsets.all(1.0.h),
      child: Container(
        child: Text(
          'ADDRESS',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  addressTextField() {
    return Padding(
      padding: EdgeInsets.all(1.0.h),
      child: TextFormField(
        controller: addressController,
        cursorColor: Theme.of(context).primaryColor,
        decoration: InputDecoration(border: OutlineInputBorder()),
        maxLines: 4,
        validator: (value) {
          if (addressController.text.isEmpty) {
            return 'Enter Address';
          }
          return null;
        },
      ),
    );
  }

  citywidget() {
    return Padding(
      padding: EdgeInsets.all(1.0.h),
      child: Container(
        child: Text(
          'CITY',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  cityTextWidget() {
    return Padding(
      padding: EdgeInsets.all(1.0.h),
      child: Container(
        child: TextFormField(
          validator: (value) {
            if (landmarkController.text.isEmpty) {
              return 'Enter landmark';
            }
            return null;
          },
          controller: landmarkController,
          cursorColor: Theme.of(context).primaryColor,
          decoration: InputDecoration(
              hintText: 'LANDMARK', border: OutlineInputBorder()),
        ),
      ),
    );
  }

  rowOneWidget() {
    return Container(
      child: Row(
        children: [
          Flexible(
            child: Padding(
              padding: EdgeInsets.all(1.0.h),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 1.0.h),
                      child: Container(
                        child: Text(
                          'CITY',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 1.0.h),
                      child: TextFormField(
                        validator: (value) {
                          if (cityController.text.isEmpty) {
                            return 'Enter City';
                          }
                          return null;
                        },
                        controller: cityController,
                        cursorColor: Theme.of(context).primaryColor,
                        decoration:
                            InputDecoration(border: OutlineInputBorder()),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 1.0.h),
                      child: Container(
                        child: Text(
                          'ZIP CODE',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 1.0.h),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (zipController.text.isEmpty) {
                            return 'Enter ZipCode';
                          }
                          return null;
                        },
                        controller: zipController,
                        cursorColor: Theme.of(context).primaryColor,
                        decoration:
                            InputDecoration(border: OutlineInputBorder()),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          //2

          Flexible(
            child: Padding(
              padding: EdgeInsets.all(1.0.h),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 1.0.h),
                      child: Container(
                        child: Text(
                          'STATE',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 1.0.h),
                      child: TextFormField(
                        validator: (value) {
                          if (stateController.text.isEmpty) {
                            return 'Enter State';
                          }
                          return null;
                        },
                        controller: stateController,
                        cursorColor: Theme.of(context).primaryColor,
                        decoration:
                            InputDecoration(border: OutlineInputBorder()),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 1.0.h),
                      child: Container(
                        child: Text(
                          'COUNTRY',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 1.0.h),
                      child: TextFormField(
                        validator: (value) {
                          if (countryController.text.isEmpty) {
                            return 'Enter Country';
                          }
                          return null;
                        },
                        controller: countryController,
                        cursorColor: Theme.of(context).primaryColor,
                        decoration:
                            InputDecoration(border: OutlineInputBorder()),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  saveAddressbutton() {
    return InkWell(
      onTap: () {
        if (_formKey.currentState.validate()) {
          print('saved');
          AddressModel addressModel = AddressModel(
              address: addressController.text,
              cityLandMark: landmarkController.text,
              city: cityController.text,
              zipCode: int.parse(zipController.text),
              state: stateController.text,
              country: countryController.text);
          BlocProvider.of<AddressBloc>(context)
              .add(SaveNewAddressEvent(addressModel: addressModel));
          //Navigator.pop(context);
        }
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.0.w, vertical: 2.0.h),
        child: Container(
          alignment: Alignment.center,
          //padding: EdgeInsets.only(top: 2.0.h),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).primaryColor),
          width: double.infinity,
          height: 60,
          child: Text(
            'SAVE ADDRESS ',
            style: TextStyle(
                color: Colors.white,
                fontSize: 22.0.sp,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
