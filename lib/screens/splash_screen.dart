import 'dart:async';

import 'package:flutter/material.dart';
import 'package:neostore/main.dart';
import 'package:neostore/pallet.dart';
import 'package:neostore/screens/home_page.dart';
import 'package:neostore/screens/login_page.dart';
import 'package:neostore/shared_preference/shared_preference.dart';
import 'package:sizer/sizer.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<dynamic> loggedStatus = SharedPrefernceData.getLoggedUserStatus();
  bool status;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loggedStatus.then((value) {
      setState(() {
        status = value;
      });
    });
    Timer(
        Duration(milliseconds: 400),
        () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    status == true ? HomePage() : LoginPage())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    colorFilter:
                        ColorFilter.mode(Colors.black38, BlendMode.darken),
                    image: AssetImage('assets/images/NeoSOFT.png'),
                    fit: BoxFit.cover)),
          ),
          Container(
            width: double.infinity,
            //color: Colors.amber,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: Text(
                    'NeoSTORE',
                    style: neoStoreTextStyle,
                  ),
                ),
                Container(
                  height: 20.0.h,
                  width: 10.0.w,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/splash_logo.jpg'))),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
