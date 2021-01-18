import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neostore/bloc/HomeBloc/homeBloc.dart';
import 'package:neostore/bloc/HomeBloc/home_bloc_events.dart';
import 'package:neostore/bloc/HomeBloc/home_bloc_states.dart';
import 'package:neostore/bloc/productListBloc/productList_events.dart';
import 'package:neostore/bloc/productListBloc/product_bloc.dart';
import 'package:neostore/pallet.dart';
import 'package:neostore/screens/myAccount.dart';
import 'package:neostore/screens/myCart.dart';
import 'package:neostore/screens/myOrders.dart';
import 'package:neostore/screens/product_list.dart';
import 'package:neostore/screens/store_locator.dart';
import 'package:neostore/shared_preference/shared_preference.dart';
import 'package:neostore/widgets/image_slider.dart';
import 'package:neostore/widgets/product_grid.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:neostore/model/get_user_detail_model.dart';

class HomePage extends StatefulWidget {
  // String access_Token;
  // HomePage({@required this.access_Token}) : assert(access_Token != null);

  // GetUserDetailModel userDetailModel;
  // HomePage({this.userDetailModel}) : assert(userDetailModel != null);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<dynamic> currentAccessToken = SharedPrefernceData.getToken();
  // GetUserDetailModel getUserDetailModel;
  bool iscollapse = true;
  double screenWidth, screenHeight;
  var accessToken;
  @override
  void initState() {
    super.initState();

    print(currentAccessToken);
    currentAccessToken.then((value) {
      print(value);
      setState(() {
        accessToken = value;
      });

      // BlocProvider.of<HomeBloc>(context)
      //     .add(HomeBlocData(accessToken: value));
    });
    // BlocProvider.of<HomeBloc>(context)
    //     .add(HomeBlocData(accessToken: currentAccessToken));
    // currentAccessToken.then((value) {
    //   setState(() {
    //     BlocProvider.of<HomeBloc>(context)
    //         .add(HomeBlocData(accessToken: value));
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    // getUserDetailModel = widget.userDetailModel;
    setState(() {
      BlocProvider.of<HomeBloc>(context)
          .add(HomeBlocData(accessToken: accessToken));
    });

    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;
    return Scaffold(
        body: Stack(children: [
      BlocBuilder<HomeBloc, HomeBlocStates>(
        builder: (context, state) {
          if (state is InitialHomeBloc) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Theme.of(context).primaryColor,
              ),
            );
          }
          if (state is HomeBlocSuccessState) {
            return drawerMenu(context, state.getUserDetailModel);
          }
          if (state is HomeBlocFailureState) {
            return Container(
              child: Text(state.loginErrorModel.userMsg),
            );
          }
        },
      ),
      mainPage(context)
    ]));
  }

  Widget drawerMenu(
      BuildContext context, GetUserDetailModel getUserDetailModel) {
    //return BlocBuilder<HomeBloc, HomeBlocStates>(builder: (context, state) {
    // if (state is InitialHomeBloc) {
    //   return CircularProgressIndicator();
    // }
    // if (state is HomeBlocSuccessState) {
    var data = getUserDetailModel.data.userData;
    return Container(
      padding: EdgeInsets.only(top: 7.0.h, left: 1.5.h, right: 10.0.h),
      color: Colors.black,
      child: Column(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.circular(60),
                    image: DecorationImage(
                        image: data.profilePic == ''
                            ? AssetImage('assets/images/profile.jpg')
                            : NetworkImage(data.profilePic))),
              ),
              Divider(
                height: 10,
              ),
              Text(
                '${data.username}',
                style: TextStyle(
                    fontSize: 23.0.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              Divider(
                height: 5,
              ),
              Text('${data.email}',
                  style: TextStyle(
                      fontSize: 15.0.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w500)),
            ],
          ),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: [
                Card(
                    color: Colors.black,
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyCartScreen(
                                      accessToken: accessToken,
                                    ))).then((value) {
                          setState(() {});
                        });
                      },
                      leading: Image.asset(
                        'assets/images/shopping_cart.png',
                        height: 30.0,
                        width: 30.0,
                      ),
                      trailing: Container(
                        alignment: Alignment.center,
                        height: 40,
                        width: 40,
                        child: Text(
                          '${getUserDetailModel.data.totalCarts}',
                          style: textFieldStyle,
                        ),
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      title: Text(
                        'My Cart',
                        style: textFieldStyle,
                      ),
                    )),
                Card(
                    color: Colors.black,
                    child: ListTile(
                      onTap: () {
                        BlocProvider.of<ProductListBloc>(context)
                            .add(ShowProductList(productId: '1'));
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProductList(
                                      title: 'Tables',
                                      productCategoryId: '1',
                                    ))).then((value) {
                          setState(() {});
                        });
                      },
                      leading: Image.asset(
                        'assets/images/table.png',
                        height: 30.0,
                        width: 30.0,
                      ),
                      title: Text('Tables', style: textFieldStyle),
                    )),
                Card(
                    color: Colors.black,
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProductList(
                                      title: 'Sofas',
                                      productCategoryId: '3',
                                    ))).then((value) {
                          setState(() {});
                        });
                      },
                      leading: Image.asset(
                        'assets/images/sofa.png',
                        height: 30.0,
                        width: 30.0,
                      ),
                      title: Text('Sofas', style: textFieldStyle),
                    )),
                Card(
                    color: Colors.black,
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProductList(
                                      title: 'Chairs',
                                      productCategoryId: '2',
                                    ))).then((value) {
                          setState(() {});
                        });
                      },
                      leading: Image.asset(
                        'assets/images/chair.png',
                        height: 30.0,
                        width: 30.0,
                      ),
                      title: Text('Chairs', style: textFieldStyle),
                    )),
                Card(
                    color: Colors.black,
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProductList(
                                      title: 'Cupboard',
                                      productCategoryId: '4',
                                    ))).then((value) {
                          setState(() {});
                        });
                      },
                      leading: Image.asset(
                        'assets/images/cupboard.png',
                        height: 30.0,
                        width: 30.0,
                      ),
                      title: Text('Cupboards', style: textFieldStyle),
                    )),
                Card(
                    color: Colors.black,
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyAccountPage(
                                      accessToken: accessToken,
                                    ))).then((value) {
                          setState(() {});
                        });
                      },
                      leading: Image.asset(
                        'assets/images/username_icon.png',
                        height: 30.0,
                        width: 30.0,
                      ),
                      title: Text('My Account', style: textFieldStyle),
                    )),
                Card(
                    color: Colors.black,
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => StoreLocatorPage()));
                      },
                      leading: Image.asset(
                        'assets/images/storelocator_icon.png',
                        height: 30.0,
                        width: 30.0,
                      ),
                      title: Text('Store Locator', style: textFieldStyle),
                    )),
                Card(
                    color: Colors.black,
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyOrdersScreen(
                                      accessToken: accessToken,
                                    ))).then((value) {
                          setState(() {});
                        });
                      },
                      leading: Image.asset(
                        'assets/images/myorders_icon.png',
                        height: 30.0,
                        width: 30.0,
                      ),
                      title: Text('My Orders', style: textFieldStyle),
                    )),
                Card(
                    color: Colors.black,
                    child: ListTile(
                      leading: Image.asset(
                        'assets/images/logout_icon.png',
                        height: 30.0,
                        width: 30.0,
                      ),
                      title: Text('Logout', style: textFieldStyle),
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget mainPage(BuildContext context) {
    return AnimatedPositioned(
        top: iscollapse ? 0 : 0.2 * screenHeight,
        bottom: iscollapse ? 0 : 0.2 * screenWidth,
        left: iscollapse ? 0 : 0.8 * screenWidth,
        right: iscollapse ? 0 : -0.4 * screenWidth,
        child: Material(
          elevation: 8,
          color: Colors.white,
          child: Container(
            padding: EdgeInsets.only(left: 1, top: 60, right: 1),
            child: Column(
              children: [
                Container(
                  height: 5.0.h,
                  color: Theme.of(context).primaryColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      InkWell(
                        child: Image.asset('assets/images/menu_icon.png'),
                        onTap: () {
                          setState(() {
                            iscollapse = !iscollapse;
                          });
                        },
                      ),
                      Text(
                        'NeoSTORE',
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      Image.asset('assets/images/search_icon.png')
                    ],
                  ),
                ),
                ImageSlider(),
                //SizedBox(height: 2.0.h),
                productGrid(context)
              ],
            ),
          ),
        ),
        duration: Duration(milliseconds: 400));
  }
}
