import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neostore/bloc/AddressBloc/addressBloc.dart';
import 'package:neostore/bloc/CartBloc/CartBloc.dart';
import 'package:neostore/bloc/HomeBloc/homeBloc.dart';
import 'package:neostore/bloc/editProfileBloc/editProfileBloc.dart';
import 'package:neostore/bloc/forgotPasswordBloc/forgotPassword_bloc.dart';
import 'package:neostore/bloc/loginBloc/loginBloc.dart';
import 'package:neostore/bloc/myAccountBloc/myAccountBloc.dart';
import 'package:neostore/bloc/myOrdersBloc.dart/myOrdersBloc.dart';
import 'package:neostore/bloc/productDetailBloc.dart/productDetailBloc.dart';
import 'package:neostore/bloc/productListBloc/product_bloc.dart';
import 'package:neostore/bloc/registerBloc/registerBloc.dart';
import 'package:neostore/bloc/resetPasswordBloc/resetPassword_bloc.dart';
import 'package:neostore/screens/home_page.dart';
import 'package:neostore/screens/login_page.dart';
import 'package:neostore/screens/splash_screen.dart';
import 'package:neostore/shared_preference/shared_preference.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (context) => RegisterBloc()),
    BlocProvider(
      create: (context) => LoginBloc(),
    ),
    BlocProvider(create: (context) => ForgotPasswordBloc()),
    BlocProvider(create: (context) => HomeBloc()),
    BlocProvider(create: (context) => EditProfileBloc()),
    BlocProvider(create: (context) => ResetPasswordBloc()),
    BlocProvider(create: (context) => ProductListBloc()),
    BlocProvider(create: (context) => ProductDetailBloc()),
    BlocProvider(create: (context) => CartBlocList()),
    BlocProvider(create: (context) => AddressBloc()),
    BlocProvider(create: (context) => MyOrdersBloc()),
    BlocProvider(create: (context) => MyAccountBloc())
  ], child: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Future<dynamic> loggedStatus = SharedPrefernceData.getLoggedUserStatus();
  // bool status;
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   loggedStatus.then((value) {
  //     setState(() {
  //       status = value;
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(builder: (context, orientation) {
        SizerUtil().init(constraints, orientation);
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              primaryColor: Color(0xffe91c1a),
              //primaryColor: Colors.white,
              accentColor: Colors.white,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: SplashScreen()
            //LoginPage()
            //LoginPage()
            //status == true ? HomePage() : LoginPage(),
            );
      });
    });
  }
}
