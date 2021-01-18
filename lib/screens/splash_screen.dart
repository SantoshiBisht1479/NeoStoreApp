import 'package:flutter/material.dart';
import 'package:neostore/pallet.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  colorFilter:
                      ColorFilter.mode(Colors.black38, BlendMode.darken),
                  image: AssetImage('assets/images/NeoSOFT.png'),
                  fit: BoxFit.cover)),
        ),
        Align(
          alignment: Alignment.center,
          child: Column(
            children: [
              Container(
                child: Text(
                  'NeoSTORE',
                  style: neoStoreTextStyle,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
