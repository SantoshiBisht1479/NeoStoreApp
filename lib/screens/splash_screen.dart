import 'dart:async';
import 'package:flutter/material.dart';
import 'package:neostore/pallet.dart';
import 'package:neostore/screens/home_page.dart';
import 'package:neostore/screens/login_page.dart';
import 'package:neostore/shared_preference/shared_preference.dart';
import 'package:sizer/sizer.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  Future<dynamic> loggedStatus = SharedPrefernceData.getLoggedUserStatus();
  bool status;
  @override
  void initState() {
    super.initState();
    loggedStatus.then((value) {
      setState(() {
        status = value;
      });
    });
    Timer(
        Duration(seconds: 2),
        () => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    status == true ? HomePage() : LoginPage()),
            (route) => false));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    colorFilter:
                        ColorFilter.mode(Colors.black38, BlendMode.darken),
                    image: AssetImage('assets/images/NeoSOFT.png'),
                    fit: BoxFit.cover)),
          ),
          Column(
            // mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 6.0.h),
                    child: Container(
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 60.0,
                        child: Icon(
                          Icons.shopping_cart_rounded,
                          color: Theme.of(context).primaryColor,
                          size: 60,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: Text(
                      'NeoSTORE',
                      style: neoStoreTextStyle,
                    ),
                  ),
                ],
              )),
              Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 6.0.h),
                        child: Container(
                          child: Text(
                            'Welcome To NeoStore',
                            softWrap: true,
                            textAlign: TextAlign.center,
                            style: textFieldhintStyle,
                          ),
                        ),
                      )
                    ],
                  ))
            ],
          )
        ],
      ),
    );
  }
}
