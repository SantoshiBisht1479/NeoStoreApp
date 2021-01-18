import 'package:flutter/material.dart';

class StoreLocatorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          InkWell(
            onTap: () {},
            child: Image.asset('assets/images/search_icon.png'),
          )
        ],
        title: Text('Store Locator'),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/storelocator.png'),
                fit: BoxFit.fill)),
      ),
    );
  }
}
